#!/bin/bash

SYSTEM="sistema"    # Nome do sistema
MyUSER="usuario"    # Nome do usuário
MyPASS="s3nh4"      # Senha
MyHOST="localhost"  # Hostname
MyDATA="banco"      # Bando de dados
SYSDIR="/var/www/"  # Diretório do sistema
BKPDIR="/var/bk"    # Diretório de backup

ANOMES=`date +%Y%m`
ANOMESDIA=`date +%Y%m%d`

cd $BKPDIR;
if [ -d "$SYSTEM" ]
then
    cd $SYSTEM;
else
    mkdir $SYSTEM;
    cd $SYSTEM;
fi;

if [ -d $ANOMES ] 
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
