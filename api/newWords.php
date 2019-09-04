<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: content-type, X-Requested-With');
//Author: Judy Fong, Háskólinn í Reykjavík via IIIM
//Description: This script returns word stems and given a word stem returns the word, pronunciation, and contexts
//Must enable read permissions for php/curl in the appropriate folder to 

// API parameters
// GET parameter: speechID
//          i.e.: rad20180222T114624
//      required: Yes
//   description: the letters rad and timestamp of when the speech ends
//      response: JSON of the new words, phonetic transcription, and times it appears in context

// OR

// GET parameter: startDate
//          i.e.: 2019-01-02
//      required: No
//   description: YYYY-MM-DD, the day from which to start gathering words
// GET parameter: endDate
//          i.e.: 2019-12-21
//      required: No
//   description: YYYY-MM-DD, the day from which to stop gathering words
//      response: JSON of the new words, phonetic transcription, and times it appears in context

// GET parameter: top
//          i.e.: 6
//      required: No
//   description: The max number of words to display. Must be an integer.
//      response: JSON of the new words, phonetic transcription, and times it appears in context

// OR

// GET parameter: speechID
//          i.e.: rad20180222T114624
//      required: Yes
//   description: the letters rad and timestamp of when the speech ends

include('../include/config.php');
include_once('../include/errors.php');
include_once('../include/utils.php');
//functions are in the utils file

//Make sure the message is parsed properly


if ((isset($_GET['speechID']) || 
    (isset($_GET['startDate']) && isset($_GET['endDate']))|| 
    isset($_GET['wordPattern']) || 
    isset($_GET['top'])) && isset($_GET['stem'])) {
    include_once('../include/errors.php');
    include_once('../include/config.php');
    include_once('../include/mysql_config.php');
    $con=mysqli_connect($tdbaddr, $tdbuser, $tdbpass, $tdbname);
    if(mysqli_error($con)) {
        die(mysqli_error($con));
    } 
    if (!mysqli_set_charset($con, $tdbcharset)) {
       die ("failed to set character set");
    }
    //top
    $topWordsQuery = "SELECT nw.word_stem, count(nw.word) as num_contexts
            FROM contexts
            INNER JOIN words nw ON contexts.word=nw.word
            WHERE reject='0' AND lang='is' AND confirmed_word IS NULL
            GROUP BY word_stem
            ORDER BY num_contexts DESC
            LIMIT ?";

    //speechID
    $speechIDQuery = "SELECT nw.word_stem, count(nw.word) as num_contexts
            FROM contexts
            INNER JOIN words nw ON contexts.word=nw.word
            WHERE reject='0' AND lang='is' AND confirmed_word IS NULL
            AND speech_id= ?
            GROUP BY word_stem
            ORDER BY num_contexts DESC";

    //DATE
    $datesQuery = "SELECT nw.word_stem, count(nw.word) as num_contexts
            FROM contexts
            INNER JOIN words nw ON contexts.word=nw.word
            WHERE reject='0' AND lang='is' AND confirmed_word IS NULL
            AND creation_date >= ? AND creation_date <= ?
            GROUP BY word_stem
            ORDER BY num_contexts DESC";

    $counter = 0;
    header('Content-Type: application/json;charset=UTF-8');
    if (isset($_GET['top'])) {
        if ($statement = mysqli_prepare($con, 
                    $topWordsQuery)) {

            mysqli_stmt_bind_param($statement, "i", $_GET['top']);
            mysqli_stmt_execute($statement);
            mysqli_stmt_store_result($statement);
            $numWordResult = mysqli_stmt_num_rows($statement);
            mysqli_stmt_bind_result($statement, $wordStem, $numContexts);
            while(mysqli_stmt_fetch($statement)) {
                $stems[] = array('stem' => $wordStem, 'occurences' => $numContexts);
            } 
            if (isset($stems)) {
                echo json_encode($stems);
            }
            mysqli_stmt_close($statement);
        }
        
    } elseif (isset($_GET['speechID']) && validateSpeechID(htmlspecialchars($_GET['speechID']))) {
        //validate speechID and check if exists
        if ($statement = mysqli_prepare($con, 
                    $speechIDQuery)) {

            mysqli_stmt_bind_param($statement, "s", $_GET['speechID']);
            mysqli_stmt_execute($statement);
            mysqli_stmt_store_result($statement);
            $numWordResult = mysqli_stmt_num_rows($statement);
            mysqli_stmt_bind_result($statement, $wordStem, $numContexts);
            while(mysqli_stmt_fetch($statement)) {
                $stems[] = array('stem' => $wordStem, 'occurences' => $numContexts);
            } 
            if (isset($stems)) {
                echo json_encode($stems);
            }
            mysqli_stmt_close($statement);
        }
        
    } elseif (isset($_GET['startDate']) && isset($_GET['endDate'])
        && validateDate($_GET['startDate']) && validateDate($_GET['endDate']) ) {
        if ($statement = mysqli_prepare($con, 
                    $datesQuery)) {

            mysqli_stmt_bind_param($statement, "ss", $_GET['startDate'], $_GET['endDate']);
            mysqli_stmt_execute($statement);
            mysqli_stmt_store_result($statement);
            $numWordResult = mysqli_stmt_num_rows($statement);
            mysqli_stmt_bind_result($statement, $wordStem, $numContexts);
            while(mysqli_stmt_fetch($statement)) {
                $stems[] = array('stem' => $wordStem, 'occurences' => $numContexts);
            } 
            if (isset($stems)) {
                echo json_encode($stems);
            }
            mysqli_stmt_close($statement);
        }
        
    } elseif (isset($_GET['wordPattern'])) {
        if ($statement = mysqli_prepare($con, 
                "SELECT nw.word, 
                        `pronunciation`,  
                        count(nw.word) as num_contexts, 
                        group_concat(context separator '\n' ) as context_array
                FROM `contexts`
                INNER JOIN `words` nw ON contexts.word=nw.word
                WHERE reject='0' 
                    AND confirmed_word IS NULL 
                    AND lang='is'
                    AND nw.word_stem= ?
                    GROUP BY word  
                    ORDER BY num_contexts DESC")) {

            mysqli_stmt_bind_param($statement, "s", $_GET['wordPattern']);
            mysqli_stmt_execute($statement);
            mysqli_stmt_store_result($statement);
            $numWordResult = mysqli_stmt_num_rows($statement);
            mysqli_stmt_bind_result($statement, $word, $pronunciation, $numContexts, $contextArray);
            echo "[";
            $counter  = 0;
            while(mysqli_stmt_fetch($statement)) {
                echo '{ "word": "' . $word . '", ' . 
                '"pronunciation": "' .  $pronunciation . '", ' . 
                '"context": ' . json_encode(explode("\n", $contextArray), JSON_UNESCAPED_UNICODE) . 
                 '}';
                if (++$counter != $numWordResult) { 
                    // all but the last row
                    echo " ,";
                }
            } 
            echo "]";
            mysqli_stmt_close($statement);
        }
        
    } else {
        echo "Bad Request";
        http_response_code(400);
    }
    mysqli_close($con);
}
else
{
  trigger_error($lirfa_errors[800]);
  echo $lirfa_errors[800];
}
?>
