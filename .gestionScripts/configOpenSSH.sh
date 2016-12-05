#!/bin/bash

# Programmeur:			Camille Ritchie-Beaudin
# Date:				14 novembre 2016

# Programme qui fait l'installation d'Openssh-client pour l'utilisateur

/usr/local/bin/.gestionScripts/accueil.sh

read -p "Voulez-vous installer Openssh-client ? (O/N)" reponse

if [[ $reponse =~ ^[Oo]$ ]]
then
	apt-get install openssh-client
else
	if [[ $reponse =~ ^[Nn]$ ]]; then
		/usr/local/bin/.gestionScripts/accueil.sh
	else
		echo "Reponse invalide."
	fi
fi
