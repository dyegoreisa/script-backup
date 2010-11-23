#!/bin/bash

MyUSER="root"      # Nome do usuário root do banco
MyPASS="r00t"      # Senha de root do banco
MyHOST="localhost" # Hostname

ANOMES=`date +%Y%m`
ANOMESDIA=`date +%Y%m%d`

if ls $ANOMES 1> /dev/null 2> /dev/null; 
then 
    cd $ANOMES;
else 
    mkdir $ANOMES;
    cd $ANOMES;
fi;

# lista com nomes dos bancos
BANCOS="banco1 banco2 banco3 banco4"

for BANCO in $BANCOS
do
    # backup do banco
    echo "Fazendo backup do banco " $BANCO
    echo ""
    mysqldump -u $MyUSER -h $MyHOST -p$MyPASS $BANCO > $BANCO-$ANOMESDIA.sql
    bzip2 $BANCO-$ANOMESDIA.sql
    echo "Terminando!"
    echo ""
done
