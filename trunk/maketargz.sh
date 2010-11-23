#!/bin/bash
if [ $# -lt 1 ]; 
then
    echo "Favor informar o diretório"
    exit 1
fi;

if ls $1 1> /dev/null 2> /dev/null; 
then
    DIR=$1
else 
    echo "Diretório não existe"
    exit 1
fi;

mv $DIR _1_$DIR
mkdir $DIR
rsync -rcC _1_$DIR/* $DIR
tar -zcf $DIR-`date +%Y%m%d`.tar.gz $DIR
rm -rf $DIR
mv _1_$DIR $DIR

