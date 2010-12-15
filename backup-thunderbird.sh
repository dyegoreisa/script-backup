#!/bin/bash

SERVER="//157.86.205.202/dyego_backup"
DIRBK="/media/backup"
SYSDIR="/home/dyego/"
CREDENTIALS="/home/dyego/.crendentials"

ANOMES=`date +%Y%m`
ANOMESDIA=`date +%Y%m%d`
AGORA=`date`

echo "Inicio do backup do dia "$AGORA;
echo "\t\tMontando compartinhamento...";
smbmount $SERVER $DIRBK -o credentials=$CREDENTIALS

if ls $DIRBK 1> /dev/null 2> /dev/null;
then
    echo "\t\tCompartinhamento montado";
else 
    echo "[ERRO] - Erro na montagem do compartilhamento"
    exit 1;
fi;

echo "\t\tEntrando em "$DIRBK"...";
cd $DIRBK
echo "\t\tDentro de "$DIRBK;

echo "Verificando existencia do diretório "$ANOMES"...";
if ls $ANOMES 1> /dev/null 2> /dev/null; 
then 
    cd $ANOMES;
    echo "\t\tDentro do diretório "$ANOMES;
else 
    echo "\t\tCriando diretório "$ANOMES"...";
    mkdir $ANOMES;
    cd $ANOMES;
    echo "\t\tDentro do diretório "$ANOMES;
fi;

# backup do sistema
echo "\t\tEntrando no diretório "$SYSDIR;
cd $SYSDIR

echo "\t\tParando o Thunderbird..."
killall -s STOP thunderbird-bin

echo "\t\tCriando arquivo de backup...";
tar -P -czf thunderbird-$ANOMESDIA.tar.gz .thunderbird

echo "\t\tVoltando o Thunderbird..."
killall -s CONT thunderbird-bin

echo "\t\tVoltando para o diretório do backup...";
cd - 

echo "\t\tMovendo o arquivo para o diretório de backup...";
mv -v $SYSDIR"thunderbird-$ANOMESDIA.tar.gz" . 

echo "\t\tDesmontando o compartilhamento...";
umount -f $DIRBK

echo "Backup feito!\n"
