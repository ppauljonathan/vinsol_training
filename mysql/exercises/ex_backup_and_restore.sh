#!/bin/bash

# dumping paul database into mysql.txt
mysqldump -u root -p paul > mysql.txt

# creating new database restored
mysql -e "create database restored" -u root -p

# loading data from mysql.txt to restored
mysql -u root -p restored < mysql.txt
