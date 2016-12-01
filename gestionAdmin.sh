#!/bin/bash

#Menu de gestion administrateur Optik 360
#William Leblanc
#Ce script affiche et gere le menu pour les administrateur de projets.

clear
echo "Menu de gestion - Administrateur"
echo ""
echo "Bonjour $USER"
echo ""
echo "Vos projets : "
echo ""

cd ~

echo "Voici les projets dans lesquels vous êtes inclu :"
find -L . -maxdepth 1 -xtype l

echo ""
read -p "Choissisez un projet : " PROJECT

if [ -d ~/$PROJECT ];then
	SELECTION="$PROJECT"
	SELECTION_FULL=$(readlink -f ~/$PROJECT)
	SELECTION_BOTTOM=$SELECTION_FULL

	while :
	do
		clear
		echo "Projet choisi : $PROJECT"
		echo "Sélection : $SELECTION"
		echo "Sélection complète : $SELECTION_FULL" # TODO enlever
		echo ""
		echo "Contenu de la sélection : "
		echo ""

		ls -1 $SELECTION_FULL

		echo ""
		echo "G) Gestion des droits de la sélection"
		echo "A) Avancer dans la sélection"
		echo "R) Reculer dans la sélection"

		read -p "Votre choix : " CHOICE

		case $CHOICE in
			[gG])
				# TODO Gestion des droits
				;;
			[aA])
				read -p "Choisir un fichier/répertoire : " NODE

				if [ -d "$SELECTION_FULL/$NODE" ] || [ -f "$SELECTION_FULL/$NODE" ]; then
					SELECTION="$SELECTION/$NODE"
					SELECTION_FULL="$SELECTION_FULL/$NODE"
				else
					echo "Aucun dossier de ce nom existe."
				fi
				;;
			[rR])
				if [ $SELECTION_FULL = $SELECTION_BOTTOM ];then
					exit
				fi
				read
				
				SELECTION="${SELECTION%/*}"
				SELECTION_FULL="${SELECTION_FULL%/*}"
				;;
			*)
				read -p "Choix erroné. Recommencez."
				;;
		esac
	done
else
	echo "Choix erroné. Recommencez le programme."
fi
