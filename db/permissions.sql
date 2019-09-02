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

create user 'default'@'localhost';
set password for 'default'@'localhost' = PASSWORD('default');
grant select on althingi_words.words to 'default'@'localhost';
grant select on althingi_words.speeches to 'default'@'localhost';
grant select on althingi_words.speaker to 'default'@'localhost';
grant select on althingi_words.contexts to 'default'@'localhost';

grant update on althingi_words.words to 'default'@'localhost';

-- change EXTRACTORPASSWORD to something more difficult 
create user 'extractor'@'localhost' IDENTIFIED BY 'EXTRACTORPASSWORD';

grant insert on althingi_words.speeches to 'extractor'@'localhost';
grant insert on althingi_words.words to 'extractor'@'localhost';
grant insert on althingi_words.contexts to 'extractor'@'localhost';
grant insert on althingi_words.speaker to 'extractor'@'localhost';

grant select on althingi_words.words to 'extractor'@'localhost';
grant select on althingi_words.speeches to 'extractor'@'localhost';
grant select on althingi_words.speaker to 'extractor'@'localhost';
grant select on althingi_words.contexts to 'extractor'@'localhost';

grant update on althingi_words.words to 'extractor'@'localhost';

