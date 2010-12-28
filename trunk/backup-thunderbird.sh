#!/bin/bash

SERVER="//157.86.205.202/dyego_backup"
DIRBK="/media/backup"
SYSDIR="/home/dyego/"
CREDENTIALS="/home/dyego/.crendentials"

ANOMES=`date +%Y%m`
ANOMESDIA=`date +%Y%m%d`
AGORA=`date`

echo "Inicio do backup do dia "$AGORA;
echo "  Montando compartinhamento...";
smbmount $SERVER $DIRBK -o credentials=$CREDENTIALS

if ls $DIRBK 1> /dev/null 2> /dev/null;
then
    echo "  Compartinhamento montado";
else 
    echo "[ERRO] - Erro na montagem do compartilhamento"
    exit 1;
fi;

echo "  Entrando em "$DIRBK"...";
cd $DIRBK
echo "  Dentro de "$DIRBK;

echo "Verificando existencia do diretório "$ANOMES"...";
if ls $ANOMES 1> /dev/null 2> /dev/null; 
then 
    cd $ANOMES;
    echo "  Dentro do diretório "$ANOMES;
else 
    echo "  Criando diretório "$ANOMES"...";
    mkdir $ANOMES;
    cd $ANOMES;
    echo "  Dentro do diretório "$ANOMES;
fi;

# backup do sistema
echo "  Entrando no diretório "$SYSDIR;
cd $SYSDIR

echo "  Parando o Thunderbird..."
killall -s STOP thunderbird-bin

echo "  Criando arquivo de backup...";
tar -P -czf thunderbird-$ANOMESDIA.tar.gz .thunderbird

echo "  Voltando o Thunderbird..."
killall -s CONT thunderbird-bin

echo "  Voltando para o diretório do backup...";
cd - 

echo "  Movendo o arquivo para o diretório de backup...";
mv -v $SYSDIR"thunderbird-$ANOMESDIA.tar.gz" . 

echo "  Desmontando o compartilhamento...";
umount -f $DIRBK

echo "Backup feito!"
