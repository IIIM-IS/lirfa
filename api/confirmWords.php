<?php
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header("Access-Control-Allow-Headers: content-type, X-Requested-With");
//Author: Judy Fong, Háskólinn í Reykjavík
//Description: This script receives as POST: speech ID, original word, 
//replacement word, replacement pronunciation. If the original word and 
//speechID match a word in the new words directory, then save it to the mysql 
//directory

// API parameters
//      required: Yes
//   description: all the necessary information to either confirm a word or to reject it
//      response: HTTP status codes
// POST parameter: original word
// POST parameter: confirmed word
// POST parameter: pronunciation
// POST parameter: delete 
// POST parameter: word 
// Character encoding: UTF-8
//
// OR
//
// GET parameter: startDate
//          i.e.: 2019-03-06
//      required: Yes 
//   description: the year month and day of when the earlist word was confirmed
// GET parameter: endDate
//          i.e.: 2019-03-07
//      required: No
//   description: the year month and day of when the last word was confirmed
// GET parameter: pronunciation
//          i.e.: 1
//      required: No
//   description: flag to indicate that the pronunciation should be retrieved too
//      response: TSV format of confirmed words OR nothing if there are no words

// GET parameter: json
//          i.e.: 1
//      required: No
//   description: flag to indicate that the return format should be JSON
//      response: JSON format of what the user requested OR nothing if there are no words

//Credit to glavic on php.net
//http://php.net/manual/en/function.checkdate.php#113205
function validDate($date, $format = 'Y-m-d')
{
    $d = DateTime::createFromFormat($format, $date);
    return $d && $d->format($format) == $date;
}

    try{
        include('../include/mysql_config.php');
        if (!$out) {
            die("Couldn't open log file");
        }
        //SQL Connection
        $con=mysqli_connect($tdbaddr, $tdbuser, $tdbpass, $tdbname);
        if(mysqli_error($con)) {
            die(mysqli_error($con));
        } 
        if(!mysqli_set_charset($con, $tdbcharset)){
            die ("failed to set character set");
        }
        //gets the confirmed words from a certain day and outputs them as tsv or json
        if (isset($_GET['startDate'])) {
            //verify startDate is a valid date
            if( validDate($_GET['startDate'])) {
                $startDate = htmlspecialchars($_GET['startDate']);
                $wordsQuery =   "SELECT confirmed_word ";
                if (isset($_GET['pronunciation'])) {
                    $wordsQuery .= " , pronunciation ";
                }
                $wordsQuery .= " FROM words 
                                WHERE confirmed_word IS NOT NULL 
                                AND confirmation_date>='$startDate' ";
                if (isset($_GET['endDate']) && validDate($_GET['endDate'])) {
                    $endDate = htmlspecialchars($_GET['endDate']);
                    $wordsQuery .= " AND confirmation_date<'$endDate'";
                } else {
                    $wordsQuery .= " AND confirmation_date<NOW()";
                }
                $queryResult = mysqli_query($con, $wordsQuery) or die (mysqli_error($con));
                $numResults = mysqli_num_rows($queryResult);
                $counter = 0;

                if (isset($_GET['json'])) { 
                    header('Content-Type: application/json;charset=UTF-8');
                    echo "[";
                    while ($row = mysqli_fetch_array($queryResult)) {
                        echo '{ "word": "' . $row{'confirmed_word'} . '" ' ; 
                        if (isset($_GET['pronunciation'])) {
                            echo ', "pronunciation": "' .  $row{'pronunciation'} . '" ' ; 
                        }
                        echo '}';
                        if (++$counter != $numResults) { 
                            // all but the last row
                        echo ",";
                        }
                    } 
                    echo "]";
                } else { //assume user wants a tab separated file
                    header('Content-Type: text/plain;charset=UTF-8');
                    while ($row = mysqli_fetch_array($queryResult)) {
                        echo $row{'confirmed_word'} . "\t" ; 
                        if (isset($_GET['pronunciation'])) {
                            echo   $row{'pronunciation'} . "\n" ; 
                        }
                    }
                }
            } else {
                echo "Bad Request";
                http_response_code(400);
            }
        } else { //assume the user is trying to confirm new words
            header("Content-type: text/plain; charset=UTF-8");
            $_POST = json_decode(file_get_contents('php://input'), true);
            $dbUpdates = 0;
            //load in all the possible legal phones
            $phonemes=file('../phones.txt');
            foreach ($_POST["word"] as $word) {
                $newWord = htmlspecialchars($word["originalWord"]); 
                //Make sure the word has not already been confirmed or deleted
                if (isset($word["delete"]) && ($word["delete"] == true)) {
                    //Only add the reject flag if the newWord exists and the
                    //newWord hasn't been modified like the reject flag hasn't been set
                    $wordsQuery =  "UPDATE `words` 
                                    SET reject=1,
                                        confirmation_date=NOW() 
                                    WHERE reject=0 
                                    AND confirmed_word IS NULL 
                                    AND word='$newWord'";
                    if (mysqli_query($con, $wordsQuery)) {
                        $dbUpdates += 1;
                    }
                } elseif (isset($word['pronunciation']) && isset($word["confirmedWord"]) 
                  && htmlspecialchars($word["confirmedWord"]) !== '') {
                    $confirmedWord = htmlspecialchars($word['confirmedWord']);
                    $pronunciation = htmlspecialchars($word['pronunciation']);
                    //check that the pronunciation is space delimited
                    $submittedPhonemes = explode(" " , $pronunciation);
                    $numMatchingPhonemes = 0;
                    foreach($submittedPhonemes as $submittedPhoneme) {
                    //check if the characters for the pronunciation fit the 
                    //approved letters in phones.txt or maybe phones_original_file.txt
                        foreach($phonemes as $phoneme)
                        {
                            if (strcmp($submittedPhoneme, trim($phoneme)) == 0) {
                            //trim away the excess whitespace from the file phonemes
                                $numMatchingPhonemes++;
                                break;
                            }
                        }
                    }
                    if (count($submittedPhonemes) == $numMatchingPhonemes) {
                        //Check if the newWord exists in the database and has not
                        //been updated
                        fwrite($out, "Doing db update with phonemes\n");
                        $wordsQuery =  "UPDATE `words` 
                                        SET confirmed_word='$confirmedWord',
                                            confirmation_date=NOW(), 
                                            pronunciation='$pronunciation' 
                                        WHERE confirmed_word IS NULL 
                                        AND reject=0 
                                        AND word='$newWord'";
                        //add it to the database;
                        if (mysqli_query($con, $wordsQuery)) {
                            $dbUpdates += 1;
                        }
                    }
                }
            }
            mysqli_close($con);
            if ($dbUpdates == count($_POST["word"])) {
            //Number of database updates equals number of words given
                header("Content-type: text/plain; charset=UTF-8; HTTP/1.1 200 OK");
                echo "Success"; //HTTP success
                http_response_code(200);
            } else {
            //else there was at least one bad word
                echo "Accepted";
                http_response_code(202);
            }
        }
    } catch (Exception $e) {
        if (isset($con)){
            mysqli_close($con);
        }
        echo "Bad Request";
        http_response_code(400);
    } 
    $con = null;
?>
