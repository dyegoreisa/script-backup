#!/bin/bash

SYSTEM="eelagoas"                   # Nome do sistema
MyUSER="eelagoas"                   # USERNAME
MyPASS="33l4g04s"                   # PASSWORD
MyHOST="localhost"                  # Hostname
MyDATA="eelagoas"                   # Database
SYSDIR="/home/dyego/projetos/"      # Sistema

ANOMES=`date +%Y%m`
ANOMESDIA=`date +%Y%m%d`

if ls $ANOMES 1> /dev/null 2> /dev/null; 
then 
    cd $ANOMES;
else 
    mkdir $ANOMES;
    cd $ANOMES;
fi;

# backup do banco
mysqldump -u $MyUSER -h $MyHOST -p$MyPASS $MyDATA > banco-$SYSTEM-$ANOMESDIA.sql
bzip2 banco-$SYSTEM-$ANOMESDIA.sql

# backup do sistema
cd $SYSDIR
tar -P -czf sistema-$SYSTEM-$ANOMESDIA.tar.gz $SYSTEM
cd - 1> /dev/null 2> /dev/null
mv $SYSDIR"sistema-$SYSTEM-$ANOMESDIA.tar.gz" . 
