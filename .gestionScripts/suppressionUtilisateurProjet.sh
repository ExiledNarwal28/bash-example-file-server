#!/bin/bash

# Programmeur:			Camille Ritchie-Beaudin
# Date:				17 novembre 2016

# Script qui va enlever un utilisateur du projet. Pour ce faire, on le supprime du fichier.project-config


# Quand on passe des parametres au script
while getopts c:p:u: option
do
	case "${option}"
	in
		c)CLIENT=${OPTARG};; # Variable qui contient le nom du repertoire client
		p)PROJET=${OPTARG};; # Variable qui contient le nom du repertoire projet
		u)SUPPRESSED_USER=${OPTARG};; # Variable qui contient le nom d'utilisateur a supprimer du projet
	esac
done

/usr/local/bin/.gestionScripts/accueil.sh

cd /disk2/clients

#Si les parametres ne sont pas vides
if [ ! -z "$CLIENT" ] && [ ! -z "$PROJET" ] && [ ! -z "$SUPPRESSED_USER" ]
then
	cd $CLIENT/$PROJET

	grep -vwE "$SUPPRESSED_USER" .project-config > .tempo
        cp .tempo .project-config
        rm .tempo

        echo -e "\nUtilisateur '$SUPPRESSED_USER' supprime du projet '$PROJET'"
else #Si les parametres sont vides
	$CLIENT = ""

	until [[ -d "$CLIENT" ]]
	do
        	/home/optik360/ScriptsBash/Interface/accueil
	        echo -e "\nParmi les clients suivants, dans lequel de ces clients le projet que vous voulez est-il?\n"
        	ls

	        echo -e "\n"
        	read CLIENT

	        if [[ ! -d "$CLIENT" ]]; then
        	        read -p "Le client que vous avez entre n'existe pas. Appuyez sur enter pour continuer ..."
       		fi
	done

	cd $CLIENT

	FLAG_TROUVE=false

	while [[ "$FLAG_TROUVE" = false ]]
	do
	        /home/optik360/ScriptsBash/Interface/accueil
        	echo -e "\nParmi les projets suivants, veuillez entrer le nom du projet que vous voulez: \n"

	        ls

	        echo -e "\n"
        	read PROJET

        	if [[ -d "$PROJET" ]] 
        	then
                	FLAG_TROUVE=true
	        else
                	read -p "Le projet n'existe pas. Veuillez entrer le nom d'un projet qui existe. Appuyez sur enter pour continuer ..."

        	fi
	done

	cd $PROJET

	FLAG_EXISTE=false

	while [[ "$FLAG_EXISTE" = false ]]
	do
        	/home/optik360/ScriptsBash/Interface/accueil
        	echo -e "\nVeuillez entrer le nom de l'utilisateur que vous voulez supprimer du projet '$PROJET': "
	        read SUPPRESSED_USER

        	if getent passwd $SUPPRESSED_USER > /dev/null 2>&1
	        then
                	FLAG_EXISTE=true
        	else
                	read -p "L'utilisateur n'existe pas. Veuillez entrer un utilisateur existant. Appuyez sur une touche pour continuer ..."
        	fi
	done

	/home/optik360/ScriptsBash/Interface/accueil

	grep -vwE "$SUPPRESSED_USER" .project-config > .tempo
	cp .tempo .project-config
	rm .tempo

	echo -e "\nUtilisateur '$SUPPRESSED_USER' supprime du projet '$PROJET'"
fi
