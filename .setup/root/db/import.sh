#!/bin/sh
DB_USERNAME='root'
DB_PASSWORD='Toronto'
SEED_DIR='/synced/src/example.com.src/seed/'

echo 'Importing seed data ...'
for fileName in $SEED_DIR/*; do
 dbName=$(basename "$fileName")
 cmd='DROP DATABASE IF EXISTS `'$dbName'`; CREATE DATABASE `'$dbName'`;'
 echo $cmd
 mysql -u$DB_USERNAME -p$DB_PASSWORD -e "$cmd"
 mysql -u$DB_USERNAME -p$DB_PASSWORD $dbName < $fileName
done