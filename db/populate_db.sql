use althingi_words;

start transaction;

insert into speeches(id, speaker_abbreviation, thing_id) values("rad20180607T172616", "þorstV", "148");
INSERT IGNORE into words(word, pronunciation, word_stem) values("tekjuveikleika", "foo", "tekjuveikleiki");
INSERT IGNORE into words(word, pronunciation) values("analytica", "aː n a l ɪː t ɪ k");
INSERT IGNORE into words(word, pronunciation) values("árangursmælikvörðum", "auː r au ŋ k ʏ r̥ s m aiː l ɪ kʰ v œ r ð ʏ m");
INSERT IGNORE into words(word, pronunciation) values("efnahagsgreiningum", "ɛ p n a h a x s k r eiː n i ŋ k ʏ m");
INSERT IGNORE into words(word, pronunciation) values("fastgengissamstarfi", "f a s t c ei ɲ c ɪ s a m s t a r v ɪ");
INSERT IGNORE into words(word, pronunciation) values("fullveldistímabil", "f ʏ t l̥ v ɛ l t ɪ s tʰ iː m a p ɪː l");
INSERT IGNORE into words(word, pronunciation) values("fullveldistímabilsins", "f ʏ t l̥ v ɛ l t ɪ s tʰ iː m a p ɪ l s ɪ n s");
insert into contexts(word, speech_id, context) values("tekjuveikleika", "rad20180607T172616", "ögur til þess að meta t . d . þá tekjuveikleika sem kunna að reynast í henni og ");



commit;
