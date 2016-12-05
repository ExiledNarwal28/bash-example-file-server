#!/bin/bash

# Programmeur:                   Camille Ritchie-Beaudin
# Date:                          14 novembre 2016

# Script qui cree les repertoires de projets dans le repertoire client specifie


# Quand on passe les parametres au script
while getopts c:p: option
do
	case "${option}"
	in
		c) CLIENT=${OPTARG};; # Variable qui contient le nom du repertoire client
		p) PROJECT=${OPTARG};; # Variable qui contient le nom du repertoire projet que l'on veut creer
	esac
done

# Si les parametres ne sont pas vides
if [ ! -z "$CLIENT" ] && [ ! -z "$PROJECT" ]
then
	cd /disk2/clients/$CLIENT
	mkdir $PROJECT
	cd $PROJECT
	touch .project-config
        echo "#Liste des utilisateurs du projet" >> .project-config
        echo -e "\nProjet '$PROJECT'  cree."
else # Si les parametres sont vides
    /usr/local/bin/.gestionScripts/accueil.sh

	cd /disk2/clients

	$CLIENT = ""

	until [[ -d "$CLIENT" ]]
	do
        /usr/local/bin/.gestionScripts/accueil.sh
		echo -e "\nParmi les clients suivants, dans lequel de ces clients voulez-vous creer un projet ?\n"

		ls
		echo -e "\n"
		read CLIENT

		if [[ ! -d "$CLIENT" ]]; then
			read -p "Le client que vous avez entre n'existe pas. Appuyez sur enter pour continuer ..."
		fi
	done

	cd $CLIENT

	FLAG_FOUND=false

	while [[ "$FLAG_FOUND" = false ]]
	do
        /usr/local/bin/.gestionScripts/accueil.sh
		echo -e "\nVeuillez entrer le nom du projet a creer: "
		read PROJECT

		if [[ -d "$PROJECT" ]]
		then
			read -p "Le projet existe deja. Veuillez trouver un autre nom ou supprimer le projet avec le meme nom. Appuyez sur enter pour continuer ..."
		else
			FLAG_FOUND=true
		fi
	done

	mkdir $PROJECT

	cd $PROJECT

	touch .project-config
	echo "#Liste des utilisateurs du projet" >> .project-config

	echo -e "\nProjet '$PROJECT'  cree."
fi
