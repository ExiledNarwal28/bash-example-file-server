#!/bin/bash

#Programmeur:                   Camille Ritchie-Beaudin
#Date:                          14 novembre 2016
#Date de modification:

#Script qui cree les repertoires de projets dans le repertoire client specifie


#Quand on passe les parametres au script
while getopts c:p: option
do
	case "${option}"
	in
		c) CLIENT=${OPTARG};; #Variable qui contient le nom du repertoire client
		p) PROJET=${OPTARG};; #Variable qui contient le nom du repertoire projet que l'on veut creer
	esac
done


#Si les parametres ne sont pas vides
if [ ! -z "$CLIENT" ] && [ ! -z "$PROJET" ]
then
	cd /disk2/clients/$CLIENT
	mkdir $PROJET
	cd $PROJET
	touch .project-config
        echo "#Liste des utilisateurs du projet" >> .project-config
        echo -e "\nProjet '$PROJET'  cree."
else #Si les parametres sont vides
	/home/optik360/ScriptsBash/Interface/accueil

	cd /disk2/clients

	$CLIENT = ""

	until [[ -d "$CLIENT" ]]
	do
		/home/optik360/ScriptsBash/Interface/accueil
		echo -e "\nParmi les clients suivants, dans lequel de ces clients voulez-vous creer un projet ?\n"

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
		echo -e "\nVeuillez entrer le nom du projet a creer: "
		read PROJET

		if [[ -d "$PROJET" ]]
		then
			read -p "Le projet existe deja. Veuillez trouver un autre nom ou supprimer le projet avec le meme nom. Appuyez sur enter pour continuer ..."
		else
			FLAG_TROUVE=true
		fi
	done

	mkdir $PROJET

	cd $PROJET

	touch .project-config
	echo "#Liste des utilisateurs du projet" >> .project-config

	echo -e "\nProjet '$PROJET'  cree."
fi
