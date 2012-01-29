#!/bin/bash

HD="/media/My-Passport/"
PC="/home/dyego/"


DOCUMENTOS="Documentos/"
IMAGENS="Imagens/"
JOGOS="Jogos/"
MUSICA="Musica/"
VIDEOS="Videos/"
DESENHOS="Desenhos/"
DIVERSOS="Diversos/"

LISTA_DIRS=$DOCUMENTOS" "$IMAGENS" "$JOGOS" "$MUSICA" "$VIDEOS$DESENHOS" "$VIDEOS$DIVERSOS

PROJETOS="Projetos/"


TMP=/tmp/`date +%Y%m%d%s`
ANOMES=`date +%Y%m`
AGORA=`date`

echo "+-------------------------------------------------------+";
echo "Inicio do restore do dia "$AGORA;

if [ $# -eq 1 ];
then 
    if [ $1 = '-v' ]; 
    then
        echo "  Mostrando o andamento."
        TAR="tar -P -zxvf "
        CP="cp -vf "
        RSYNC="rsync -rvc "
        RM="rm -fv "
    else
        TAR="tar -P -zxf "
        CP="cp -f "
        RSYNC="rsync -rc "
        RM="rm -f "
    fi;
else 
    TAR="tar -P -zxf "
    CP="cp -f "
    RSYNC="rsync -rc "
    RM="rm -f "
fi;


echo "  Criando pasta temporaria...";
mkdir $TMP


if [ -d "$PC$PROJETOS" ]
then
    echo "  -Iniciando restaração '"$HD$PROJETOS"' dentro de "$PC
else
    echo "  -Criando diretório '"$PC$PROJETOS"' dentro de "$PC
    mkdir $PC$PROJETOS
    echo "  -Iniciando restaração '"$HD$PROJETOS"' dentro de "$PC
fi;
echo "  Entrando em "$PC$PROJETOS"...";
cd $PC$PROJETOS
echo "  Dentro";
LISTA_PROJETOS=`ls $HD$PROJETOS | grep tar.gz`;
for PROJ in $LISTA_PROJETOS
do
    echo "  -Restaurando projeto '"$PROJ"' dentro de "$PC
    $CP$HD$PROJETOS$PROJ $PC$PROJETOS
    $TAR$PC$PROJETOS$PROJ
    $RM$PC$PROJETOS$PROJ
    echo "  *Feito"
    echo
done


echo "  Entrando em "$PC"...";
cd $PC
echo "  Dentro";

for DIR in $LISTA_DIRS
do
    if [ -d "$PC$DIR" ]
    then
        echo "  -Iniciando restaração '"$HD$DIR"' dentro de "$PC
    else
        echo "  -Criando diretório '"$PC$DIR"' dentro de "$PC
        mkdir $PC$DIR
        echo "  -Iniciando restaração '"$HD$DIR"' dentro de "$PC
    fi;
    echo "  -Restaurando "$HD$DIR" dentro de "$PC
    $RSYNC$HD$DIR* $PC$DIR
    echo "  *Feito"
    echo
done

echo "Restore feito!"
date
echo "+-------------------------------------------------------+";
