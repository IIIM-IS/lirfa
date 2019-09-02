#!/bin/bash
service mysql start &
wait $!
mysql -u root < ./db/schema_setup.sql
mysql -u root < ./db/populate_db.sql
mysql -u root < ./db/permissions.sql
/usr/sbin/apache2ctl -D FOREGROUND