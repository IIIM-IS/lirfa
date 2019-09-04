use althingi_words;

start transaction;
insert into speeches(id, speaker_abbreviation, thing_id) values("rad20190829T165227", "ÞorstV", "149") ON DUPLICATE KEY UPDATE speaker_abbreviation="ÞorstV", thing_id="149";
INSERT IGNORE into words(word, pronunciation) values("flutningsmannvirkjum", "f l ʏ h t n i ŋ s m a n v ɪ r̥ c ʏ m");
INSERT IGNORE into words(word, pronunciation) values("sæstrengsframkvæmd", "s ai s t r ei ŋ s f r a m kʰ v ai m t");
INSERT IGNORE into words(word, pronunciation) values("sæstrengsmálum", "s ai s t r ei ŋ s m auː l ʏ m");
INSERT IGNORE into words(word, pronunciation) values("þjóðaréttarsérfræðingar", "θ j ouː ð a r j ɛ h t a r s j ɛ r̥ f r ai ð i ŋ k a r");
update words set word_stem="flutningsmannvirk" where word="flutningsmannvirkjum";
update words set word_stem="sæstrengsframkvæmd" where word="sæstrengsframkvæmd";
update words set word_stem="sæstrengsmál" where word="sæstrengsmálum";
update words set word_stem="þjóðaréttarsérfræðing" where word="þjóðaréttarsérfræðingar";
insert IGNORE into contexts(word, speech_id, context) values("flutningsmannvirkjum", "rad20190829T165227", "landa heldur krefst þetta uppbyggingu á flutningsmannvirkjum hér heima fyrir virkjunum mjög");
insert IGNORE into contexts(word, speech_id, context) values("sæstrengsframkvæmd", "rad20190829T165227", "er kannski öllu mikilvægara nú er sæstrengsframkvæmd gríðarlega mikil framkvæmd felur ekki");
insert IGNORE into contexts(word, speech_id, context) values("sæstrengsmálum", "rad20190829T165227", "okkar landgrunni þegar kemur að þessum sæstrengsmálum ég spyr því háttvirtan þingmann");
insert IGNORE into contexts(word, speech_id, context) values("þjóðaréttarsérfræðingar", "rad20190829T165227", "það og mér sýnist flestir okkar þjóðaréttarsérfræðingar sammála því að einmitt hafréttarsáttmálinn");


insert into speeches(id, speaker_abbreviation, thing_id) values("rad20180607T172616", "þorstV", "148");
INSERT IGNORE into words(word, pronunciation, word_stem) values("tekjuveikleika", "foo", "tekjuveikleiki");
INSERT IGNORE into words(word, pronunciation) values("analytica", "aː n a l ɪː t ɪ k");
INSERT IGNORE into words(word, pronunciation) values("árangursmælikvörðum", "auː r au ŋ k ʏ r̥ s m aiː l ɪ kʰ v œ r ð ʏ m");
INSERT IGNORE into words(word, pronunciation) values("efnahagsgreiningum", "ɛ p n a h a x s k r eiː n i ŋ k ʏ m");
INSERT IGNORE into words(word, pronunciation) values("fastgengissamstarfi", "f a s t c ei ɲ c ɪ s a m s t a r v ɪ");
INSERT IGNORE into words(word, pronunciation) values("fullveldistímabil", "f ʏ t l̥ v ɛ l t ɪ s tʰ iː m a p ɪː l");
INSERT IGNORE into words(word, pronunciation) values("fullveldistímabilsins", "f ʏ t l̥ v ɛ l t ɪ s tʰ iː m a p ɪ l s ɪ n s");
insert into contexts(word, speech_id, context) values("tekjuveikleika", "rad20180607T172616", "ögur til þess að meta t . d . þá tekjuveikleika sem kunna að reynast í henni og ");

insert into speeches(id, speaker_abbreviation, thing_id) values("rad20190829T165640", "ÞorstV", "149") ON DUPLICATE KEY UPDATE speaker_abbreviation="ÞorstV", thing_id="149";
INSERT IGNORE into words(word, pronunciation) values("Sápubað", "s au p ʏ p a ð");
INSERT IGNORE into words(word, pronunciation) values("sápukúlurnar", "s auː p ʏ kʰ uː l ʏ t n a r");
INSERT IGNORE into words(word, pronunciation) values("þjóðréttarsérfræðingar", "θ j ou ð r j ɛ h t a r s j ɛ r̥ f r ai ð i ŋ k a r");
update words set word_stem="sápub_ð" where word="Sápubað";
update words set word_stem="sápukúl" where word="sápukúlurnar";
update words set word_stem="þjóðréttarsérfræðing" where word="þjóðréttarsérfræðingar";
insert IGNORE into contexts(word, speech_id, context) values("Sápubað", "rad20190829T165640", "löngum tíma í meting um það Sápubað hvaðan sápukúlurnar koma já það");
insert IGNORE into contexts(word, speech_id, context) values("sápukúlurnar", "rad20190829T165640", "í meting um það Sápubað hvaðan sápukúlurnar koma já það er kannski");
insert IGNORE into contexts(word, speech_id, context) values("þjóðréttarsérfræðingar", "rad20190829T165640", "hlusta þegar ég heyri okkar helstu þjóðréttarsérfræðingar þegar ég heyri sérfræðinga á");



insert into speeches(id, speaker_abbreviation, thing_id) values("rad20190829T194137", "SDG", "149") ON DUPLICATE KEY UPDATE speaker_abbreviation="SDG", thing_id="149";
INSERT IGNORE into words(word, pronunciation) values("dirfumst", "t ɪ r v ʏ m s t");
INSERT IGNORE into words(word, pronunciation) values("landgrunnsafsökunin", "l a n t k r ʏ n s a f s œː k ʏ n ɪ n");
INSERT IGNORE into words(word, pronunciation) values("landgrunnsmálið", "l a n t k r ʏ n s m auː l ɪ ð");
INSERT IGNORE into words(word, pronunciation) values("landsreglarans", "l a n t s r ɛ k l a r a n s");
INSERT IGNORE into words(word, pronunciation) values("landsreglaranum", "l a n t s r ɛ k l a r a n ʏ m");
INSERT IGNORE into words(word, pronunciation) values("ríkisorkufyrirtækja", "r iː c ɪ s ɔ r̥ k ʏ f ɪː r ɪ tʰ aiː c a");
INSERT IGNORE into words(word, pronunciation) values("þægari", "θ aiː ɣ a r ɪ");
update words set word_stem="dirf" where word="dirfumst";
update words set word_stem="landgrunnsafs_k" where word="landgrunnsafsökunin";
update words set word_stem="landgrunnsmál" where word="landgrunnsmálið";
update words set word_stem="landsreglarans" where word="landsreglarans";
update words set word_stem="landsreglaranum" where word="landsreglaranum";
update words set word_stem="ríkisorkufyrirtæk" where word="ríkisorkufyrirtækja";
update words set word_stem="þæg" where word="þægari";
insert IGNORE into contexts(word, speech_id, context) values("dirfumst", "rad20190829T194137", "vera annars sagt upp ef við dirfumst að nýta greinar sem eru");
insert IGNORE into contexts(word, speech_id, context) values("landgrunnsafsökunin", "rad20190829T194137", "landgrunnið ekki síður en annað og landgrunnsafsökunin varðandi sæstreng heldur fyrir vikið");
insert IGNORE into contexts(word, speech_id, context) values("landgrunnsmálið", "rad20190829T194137", "henni hefur staðið og reyndar fyrr landgrunnsmálið í Noregi er kannski einna");
insert IGNORE into contexts(word, speech_id, context) values("landsreglarans", "rad20190829T194137", "um tengingu milli landamæra og vald landsreglarans yfir því en lítum þá");
insert IGNORE into contexts(word, speech_id, context) values("landsreglaranum", "rad20190829T194137", "að við ætlum að veita íslenskan landsreglaranum Orkustofnun þetta vald með öðrum");
insert IGNORE into contexts(word, speech_id, context) values("ríkisorkufyrirtækja", "rad20190829T194137", "uppbrot fyrirtækjanna þar með talið stórra ríkisorkufyrirtækja fyrr í sumar stefndi Evrópusambandið");
insert IGNORE into contexts(word, speech_id, context) values("þægari", "rad20190829T194137", "standa sig betur en Belgía vera þægari en Belgía í að gefa");



insert into speeches(id, speaker_abbreviation, thing_id) values("rad20190829T164408", "GBS", "149") ON DUPLICATE KEY UPDATE speaker_abbreviation="GBS", thing_id="149";
INSERT IGNORE into words(word, pronunciation) values("grænorkupakki", "k r aiː n ɔ r̥ k ʏ pʰ a h c ɪ");
INSERT IGNORE into words(word, pronunciation) values("popúlista", "pʰ ɔː p u l ɪ s t a");
INSERT IGNORE into words(word, pronunciation) values("Samfylkingarflokkarnir", "s a m f ɪ l̥ c i ŋ k a r f l ɔ h k a t n ɪ r");
INSERT IGNORE into words(word, pronunciation) values("samningsbrotamáli", "s a m n i ŋ s p r ɔː t a m auː l ɪ");
INSERT IGNORE into words(word, pronunciation) values("sármóðgaðir", "s auː r m ou ð k a ð ɪ r");
INSERT IGNORE into words(word, pronunciation) values("stefnuskjölum", "s t ɛ p n ʏ s c œː l ʏ m");
INSERT IGNORE into words(word, pronunciation) values("vetrarpakkinn", "v ɛː t r a r pʰ a h c ɪ n");
INSERT IGNORE into words(word, pronunciation) values("Viðreisnarfólk", "v ɪ ð r ei s t n a r f ou l̥ k");
INSERT IGNORE into words(word, pronunciation) values("þjóðernisnöfnum", "θ j ouː ð ɛ r t n ɪ s t n œ p n ʏ m");
update words set word_stem="grænorkup_kk" where word="grænorkupakki";
update words set word_stem="popúlista" where word="popúlista";
update words set word_stem="samfylkingarflokk" where word="Samfylkingarflokkarnir";
update words set word_stem="samningsbrotamál" where word="samningsbrotamáli";
update words set word_stem="sármóðg" where word="sármóðgaðir";
update words set word_stem="stefnuskj_l" where word="stefnuskjölum";
update words set word_stem="vetrarp_kk" where word="vetrarpakkinn";
update words set word_stem="viðreisnarfólk" where word="Viðreisnarfólk";
update words set word_stem="þjóðernisn_fn" where word="þjóðernisnöfnum";
insert IGNORE into contexts(word, speech_id, context) values("grænorkupakki", "rad20190829T164408", "sá ég einhvers staðar og einnig grænorkupakki eitthvað slíkt mjög fallegt nafn");
insert IGNORE into contexts(word, speech_id, context) values("popúlista", "rad20190829T164408", "fulltrúar Viðreisnar sem hafa kallað Miðflokksmenn popúlista ég veit ekki hvað þjóðernisnöfnum");
insert IGNORE into contexts(word, speech_id, context) values("Samfylkingarflokkarnir", "rad20190829T164408", "ekki enn þá stjórnarflokkarnir já og Samfylkingarflokkarnir allir skuli ekki hafa sagt");
insert IGNORE into contexts(word, speech_id, context) values("samningsbrotamáli", "rad20190829T164408", "að halda lendi Ísland í í samningsbrotamáli eða einhvers konar máli þegar");
insert IGNORE into contexts(word, speech_id, context) values("sármóðgaðir", "rad20190829T164408", "þegar viðræðum var slitið menn urðu sármóðgaðir að sjálfsögðu sérstaklega yfir því");
insert IGNORE into contexts(word, speech_id, context) values("stefnuskjölum", "rad20190829T164408", "sem kemur ágætlega fram í þeirra stefnuskjölum það sem kemur fram í");
insert IGNORE into contexts(word, speech_id, context) values("vetrarpakkinn", "rad20190829T164408", "fjórða orkupakkann hann hefur verið kallaður vetrarpakkinn sá ég einhvers staðar og");
insert IGNORE into contexts(word, speech_id, context) values("Viðreisnarfólk", "rad20190829T164408", "fánann það eru góð tíðindi þegar Viðreisnarfólk talar þannig um Miðflokksmenn ég");
insert IGNORE into contexts(word, speech_id, context) values("þjóðernisnöfnum", "rad20190829T164408", "Miðflokksmenn popúlista ég veit ekki hvað þjóðernisnöfnum einhverjum ég veit ekki hvað");



commit;
