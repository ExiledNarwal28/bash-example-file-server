#!/bin/bash

#Programmeur:			Camille Ritchie-Beaudin
#Date:				14 novembre 2016
#Date de modification:		

#Programme qui fait l'installation d'Openssh-client pour l'utilisateur


/home/optik360/ScriptsBash/Interface/accueil

echo "Voulez-vous installer Openssh-client ? (O/N)"
read reponse
echo ""
if [[ $reponse =~ ^[Oo]$ ]]
then
	apt-get install openssh-client
else
	if [[ $reponse =~ ^[Nn]$ ]]; then
		/home/optik360/ScriptsBash/Interface/accueil
	else
		echo "Reponse invalide."
	fi
fi
