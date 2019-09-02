/*
Copyright 2019 Judy Fong. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/*
File author/s:
    Judy Fong <lirfa@judyyfong.xyz> 
*/

-- schema for althingi_words, a database to keep info about new words in speeches

/* -------------------------------------------------------- *
   WARNING: THIS FILE DELETES ALL DATA IN althingi_words
 * -------------------------------------------------------- */

drop database if exists althingi_words;
create database althingi_words character set utf8mb4 collate utf8mb4_bin;
use althingi_words; -- set as default (current)

set collation_connection = 'utf8mb4_bin';

start transaction;

alter database althingi_words character set utf8mb4 collate utf8mb4_bin;

-- create primary key constraints as two parameters
create table words (
    word varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    transliteration varchar(300),
    confirmed_word varchar(300),
    pronunciation varchar(160) not null,
    reject boolean not null DEFAULT 0,
    discouraged boolean not null DEFAULT 0,
    lang char(2) not null DEFAULT 'is',
    original boolean not null DEFAULT 0,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    confirmation_date TIMESTAMP,
    word_stem varchar(90),
    primary key(word, pronunciation)
);
alter table words convert to character set utf8mb4 collate utf8mb4_bin;

create table speeches (
    id varchar(18) not null primary key,
    speaker_abbreviation varchar(10) not null,
    speech_type char(3) not null,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_timestamp TIMESTAMP NOT NULL,
    transcription_time_seconds integer,
    audio_length_seconds integer,
    resubmit boolean not null DEFAULT 0,
    WER decimal(8,2),
    more_resources boolean not null DEFAULT 0,
    thing_id int not null
);
alter table speeches convert to character set utf8mb4 collate utf8mb4_bin;

create table contexts (
    id int not null auto_increment primary key,
    speech_id varchar(18) not null,
    word varchar(90) not null,
    context varchar(300) not null,
    unique index (speech_id, word),
    foreign key (speech_id) references speeches(id),
    foreign key (word) references words(word)
);
alter table contexts convert to character set utf8mb4 collate utf8mb4_bin;

create table speaker (
    id int not null auto_increment primary key,
    full_name varchar(255) not null, 
    speech_id varchar(18) not null, 
    speaker_abbreviation varchar(10) not null, -- just like a username
    foreign key (speech_id) references speeches(id)
);
alter table speaker convert to character set utf8mb4 collate utf8mb4_bin;

commit;
