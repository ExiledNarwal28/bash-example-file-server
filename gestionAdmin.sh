#!/bin/bash

# Menu de gestion administrateur Optik 360
# William Leblanc et Fabien Roy
# Ce script affiche et gere le menu pour les administrateur de projets.

clear
echo "Menu de gestion - Administrateur"
echo ""
echo "Bonjour $USER"
echo ""
echo "Vos projets : "
echo ""

cd ~

echo "Voici les projets dans lesquels vous êtes inclu :"
echo ""
find -L . -maxdepth 1 -xtype l | sed 's/^..//'

echo ""
read -p "Choissisez un projet : " PROJECT

if [ -d ~/$PROJECT ];then
	SELECTION="$PROJECT" # Selection, soit ce qui sera envoyé à la gestion des droits
	SELECTION_FULL=$(readlink -f ~/$PROJECT) # Le path complet de la sélection
	SELECTION_BOTTOM=$SELECTION_FULL # Le path complet du root du projet

	while :
	do
		cd $SELECTION_FULL

		clear
		echo "Projet choisi : $PROJECT"
		echo ""
		echo "Sélection : $SELECTION"
		echo ""
		echo "  Contenu de la sélection : "
		echo ""

		echo "    [Répertoires]"
		find . -maxdepth 1 -not -path ".\/.*" -type d | sed 's/^..//'
		echo ""

		echo "    [Fichiers]"
		find . -maxdepth 1 -not -path ".\/.*" -type f | sed 's/^..//'
		echo ""

		echo "G) Gestion des droits de la sélection"
		echo "A) Avancer dans la sélection"
		echo "R) Reculer dans la sélection"

		echo ""
		read -p "Votre choix : " CHOICE

		case $CHOICE in
			[gG])
				read
				/bin/bash /usr/local/bin/.gestionScripts/droitsSeul.sh $SELECTION_BOTTOM $SELECTION_FULL
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
					read
					exit
				fi
				
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
