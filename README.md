# README #

### What is this repository for? ###

This is a fork of cadia-lvl/lirfa which contains the new words backend api for the Icelandic Parliamentary Speech Transcription System, Johnny.
The web service sends new words and receives confirmed words. 
The new words are generated by the ASR.

### How do I get set up? ###
This fork was created for the purpose of containerizing the original. 
In order to create a docker image, do:
docker build .

Then you may run the docker image:
docker run -d -p some-port:80 --name some-container-name image-id 
	
Now the lirfa server should be listening on localhost:some-port


### How does Lirfa work? ###

Definition & Usage:

Root URL:

Retrieves new words from the speechID or the time interval of when the new words were added to the database. 
Saves confirmed words.

Technical Details: 

Syntax:

#### 1. retrieve new words by dates

**URL:** api/newWords.php

**GET parameters:** startDate, endDate

**FORMAT:** YYYY-MM-DD 

**GET parameter:** stem

**DESCRIPTION:** the day from which to start gathering words 
             AND 
            the day from which to stop gathering words
		AND 
		to indicate want the stem form
i.e.: 2019-12-21

**REQUIRED:** Optional

**RESP. for valid params:** JSON of the stems and occurences

**RESP. for invalid params:** Error messages
e.g.: newWords/?stem&startDate=2019-01-20&endDate=2019-01-30

**URL:** api/newWords.php

**GET parameters:** speechID

**FORMAT:** radYYYYMMDDThh:mm:ss

**GET parameter:** stem

**DESCRIPTION:** the speechID where these words appeared
		AND 
		to indicate want the stem form
i.e.: rad20191221T120112

**REQUIRED:** Optional

**RESP. for valid params:** JSON of the stems and occurences

**RESP. for invalid params:** Error messages
e.g.: newWords/?stem&speechID=rad20191221T120112

**URL:** api/newWords.php

**GET parameters:** top

**FORMAT:** #

**GET parameter:** stem

**DESCRIPTION:** the top X stems
		AND 
		to indicate want the stem form
i.e.: 50

**REQUIRED:** Optional

**RESP. for valid params:** JSON of the stems and occurences

```
[
{"stem":"\u00f3vissusvigr\u00fam","occurences":42},
{"stem":"kj\u00f6tm\u00e1l","occurences":34},
{"stem":"samfylkingarflokk","occurences":32},
{"stem":"l\u00edfskjarasamning","occurences":31},
{"stem":"mi\u00f0flokksf\u00f3lk","occurences":30},
{"stem":"orkupakkam\u00e1l","occurences":28},
{"stem":"stj\u00f3rnskipunarv_nd","occurences":27},
{"stem":"stj\u00f3rnarskr\u00e1rleg","occurences":26}
]
```

e.g.: newWords/?stem&top=50

#### 2. send confirmed/deleted words

**URL:** api/confirmWords.php

**POST:** 
```
{word: [{originalWord: "", confirmedWord: "", pronunciation: ""},
                   {originalWord: "", delete: "true" }
                  ]}
```

**POST keys:** word, originalWord, delete, confirmedWord, prounciation

**DESCRIPTION:** JSON where the main object contains the key: word, which consists of an array of objects. 
      The objects need to have the following
      keys and corresponding values: originalWord & delete 
      OR 
      keys and corresponding values: originalWord, confirmedWord, pronunciation.
e.g.: {"word": [
                {"originalWord": "efnahagsgreiningum", "delete":"true"},
                { "originalWord":"analytica","confirmedWord": "Analytical", "pronunciation":"aː n a l ɪː t ɪ     k"}
               ]
      }

**REQUIRED:** optional

**RESP. for params:** HTTP STATUS codes

#### 3. get list of confirmed words (with pronunciation and/or JSON format)

**URL:** api/confirmWords.php

**GET parameter:** startDate
i.e.: 2019-03-06

**REQUIRED:** Yes 

**DESCRIPTION:** the year month and day of when the earlist desired word was confirmed

**GET parameter:** endDate
i.e.: 2019-03-07

**REQUIRED:** No

**DESCRIPTION:** the year month and day of when the last word was confirmed

**GET parameter:** pronunciation
i.e.: 1

**REQUIRED:** No

**DESCRIPTION:** flag to indicate that the pronunciation should be retrieved too

**RESP.:** TSV format of confirmed words OR nothing if there are no words

**GET parameter:** json
i.e.: 1

**REQUIRED:** No

**DESCRIPTION:** flag to indicate that the return format should be JSON

**RESP.:** JSON format of what the user requested OR nothing if there are no words

Logs are in their default php, mysql, and apache directory.

### Contribution guidelines ###

* Writing tests
  Write tests in the test/test_scripts directory
  Make sure they work from the php localhost:8000 server you can setup locally
* Code review
* Other guidelines

### Who do I talk to? ###

Judy Fong judyfong@ru.is
