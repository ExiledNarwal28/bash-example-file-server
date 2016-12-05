#!/bin/bash

# Programmeur:                   Camille Ritchie-Beaudin
# Date:                          14 novembre 2016

# Script qui cree le repertoire d'un client qui accueilleras les repertoires de projets
# lui appartenant.

# Quand on pase les paramètres pour le script
while getopts c: option
do
	case "${option}"
	in
		c) CLIENT=${OPTARG};; # Nom du repertoire choisi pour le repertoire client
	esac
done


if [ ! -z "$CLIENT" ]
then
	cd /disk2/clients/
    mkdir $CLIENT

	cd /home/
	mkdir $CLIENT

        echo "Repertoire client cree."
else
	/usr/local/bin/.gestionScripts/accueil.sh

	echo -e "\nVeuillez entrer le nom du client que vous voulez creer: "
	read CLIENT
	echo -e "\nVous avez entre le nom '$CLIENT'. Est-ce exact ? (O/N)"
	read REPONSE

	if [[ $REPONSE =~ ^[Oo]$ ]]
	then
		cd /disk2/clients/
		mkdir $CLIENT

		cd /home/
		mkdir $CLIENT

        	echo "Repertoire client cree."
	else
        	read -p "Annulation de la creation ..."
	fi 
fi
