#!/bin/bash

SERVER="//157.86.205.202/dyego_backup"
DIRBK="/media/backup"
SYSDIR="/home/dyego/"
CREDENTIALS="/home/dyego/.crendentials"

ANOMES=`date +%Y%m`
AGORA=`date`

echo "+-------------------------------------------------------+";
echo "Inicio do backup do dia "$AGORA;
echo "  Montando compartinhamento...";
if smbmount $SERVER $DIRBK -o credentials=$CREDENTIALS 1> /dev/null 2> /dev/null;
then
    echo "  Compartinhamento montado";
else 
    echo "[ERRO] - Erro na montagem do compartilhamento"
    exit 1;
fi;

echo "  Entrando em "$DIRBK"...";
cd $DIRBK
echo "  Dentro de "$DIRBK;

echo "  Parando o Thunderbird..."
killall -s STOP thunderbird-bin

echo "  Criando arquivo de backup...";
tar -P -czf thunderbird-$ANOMES.tar.gz .thunderbird

echo "  Voltando o Thunderbird..."
killall -s CONT thunderbird-bin

echo "  Voltando para o diretório do backup...";
cd - 1> /dev/null 2> /dev/null;

echo "  Movendo o arquivo para o diretório de backup...";
mv -vf $SYSDIR"thunderbird-$ANOMES.tar.gz" . 

echo "  Desmontando o compartilhamento...";
if umount -f $DIRBK 1> /dev/null 2> /dev/null;
then
    echo "  Compartilhamento desmontado";
else
    echo "[ERRO] - Não foi possível desmostar o compartilhamento.";
fi;

echo "Backup feito!"
echo "+-------------------------------------------------------+";
