#!/bin/bash

SERVER="//157.86.205.202/dyego_backup"
DIRBK="/media/backup"
SYSDIR="/home/dyego/"
CREDENTIALS="/home/dyego/.crendentials"

TMP=/tmp/`date +%Y%m%d%s`
ANOMES=`date +%Y%m`
AGORA=`date`

TAR="tar -P -czf "

echo "+-------------------------------------------------------+";
echo "Inicio do backup do dia "$AGORA;

echo "  Criando pasta temporaria...";
mkdir $TMP

echo "  Montando compartinhamento...";
if smbmount $SERVER $DIRBK -o credentials=$CREDENTIALS 1> /dev/null 2> /dev/null;
then
    echo "  Compartinhamento montado";
else 
    echo "[ERRO] - Erro na montagem do compartilhamento"
    exit 1;
fi;

echo "  Entrando em "$SYSDIR"...";
cd $SYSDIR
echo "  Dentro de "$SYSDIR;

echo "  Parando o Thunderbird..."
killall -s STOP thunderbird-bin

echo "  Criando arquivo de backup do Thunderbird...";
$TAR$TMP/thunderbird-$ANOMES.tar.gz .thunderbird

echo "  Voltando o Thunderbird..."
killall -s CONT thunderbird-bin

echo "  Criando arquivo de backup da pasta Documentos...";
$TAR$TMP/documentos-$ANOMES.tar.gz Documentos

echo "  Criando arquivo de backup da pasta SQLs...";
$TAR$TMP/SQLs-$ANOMES.tar.gz SQLs

echo "  Criando arqivos de backup da pasta Desktop...";
$TAR$TMP/Desktop-$ANOMES.tar.gz Desktop

echo "  Criando arquivo de backup da parta outros...";
$TAR$TMP/outros-$ANOMES.tar.gz outros

echo "  Movendo o arquivo do Thunderbird para o diretório de backup...";
mv -vf $TMP/* $DIRBK 

echo "  Desmontando o compartilhamento...";
if umount -f $DIRBK 1> /dev/null 2> /dev/null;
then
    echo "  Compartilhamento desmontado";
else
    echo "[ERRO] - Não foi possível desmostar o compartilhamento.";
fi;

echo "Backup feito!"
echo "+-------------------------------------------------------+";
