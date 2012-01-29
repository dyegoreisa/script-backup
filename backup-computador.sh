#!/bin/bash

HD="/media/My-Passport/"
PC="/home/dyego/"
HM="/home/"

DOCUMENTOS="Documentos/"
IMAGENS="Imagens/"
JOGOS="Jogos/"
MUSICA="Musica/"
VIDEOS="Videos/"
DESENHOS="Desenhos/"
DIVERSOS="Diversos/"
SERIES="Series/"
FILMES="mldonkey/files/"
BKTRABALHO="bk-trabalho/"
DESKTOP="Área\ de\ Trabalho/"

LISTA_DIRS=$DOCUMENTOS" "$IMAGENS" "$JOGOS" "$MUSICA" "$VIDEOS" "$BKTRABALHO" "$DESKTOP
LISTA_HOMES="vanessa beatriz"

PROJETOS="Projetos/"
HOMES="Homes/"

TMP=/tmp/`date +%Y%m%d%s`
ANOMES=`date +%Y%m`
AGORA=`date`

echo "+-------------------------------------------------------+";
echo "Inicio do backup do dia "$AGORA;

if [ $# -eq 1 ];
then 
    if [ $1 = '-v' ]; 
    then
        echo "  Mostrando o andamento."
        TAR="tar -P -czvf "
        MV="mv -vf "
        CP="cp -vf "
        RSYNC="rsync -rvc "
    else
        TAR="tar -P -czf "
        MV="mv -f "
        CP="cp -f "
        RSYNC="rsync -rc "
    fi;
else 
    TAR="tar -P -czf "
    MV="mv -f "
    CP="cp -f "
    RSYNC="rsync -rc "
fi;


echo "  Criando pasta temporaria...";
mkdir $TMP


echo "  Entrando em "$HM"...";
cd $HM
echo "  Dentro";

for HOME in $LISTA_HOMES
do
    echo "  -Compactando home '"$HOME"' dento de "$HD
    $TAR$HD$HOMES$HOME.tar.gz $HOME
done


echo "  Entrando em "$PC$PROJETOS"...";
cd $PC$PROJETOS
echo "  Dentro";

LISTA_PROJETOS=`ls`;
for PROJ in $LISTA_PROJETOS
do
    echo "  -Compactando projeto '"$PROJ"' dentro de "$HD
    $TAR$HD$PROJETOS$PROJ.tar.gz $PROJ
    echo "  *Feito"
    echo
done


echo "  Entrando em "$PC"...";
cd $PC
echo "  Dentro";

for DIR in $LISTA_DIRS
do
    if [ -d "$HD$DIR" ]
    then
        echo "  -Iniciando backup '"$PC$DIR"' dentro de "$HD
    else
        echo "  -Criando diretório '"$HD$DIR"' dentro de "$HD
        mkdir $HD$DIR
        echo "  -Iniciando backup '"$PC$DIR"' dentro de "$HD
    fi;
    echo "  -Executando backup "$PC$DIR" dentro de "$HD
    $RSYNC$PC$DIR* $HD$DIR
    echo "  *Feito"
    echo
done

echo "Backup feito!"
date
echo "+-------------------------------------------------------+";
