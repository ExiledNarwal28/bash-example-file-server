#!/bin/bash

# Programmeur:			Camille Ritchie-Beaudin
# Date:				24 novembre 2016

# Script qui ajoute l'usager dans un fichier cache .project-config. Ses droits seront ecrits avant
# Son nom. Ex.(admin usager1....user usager2)

# Les paramètres qu'on doit utiliser si on ne veut pas interargir avec le script (utilisateur plus avance)
while getopts c:p:u:a: option
do
	case "${option}"
	in
		c) CLIENT=${OPTARG};;  # Le nom du repertoire client
		p) PROJECT=${OPTARG};; # Le nom du repertoire projet
		u) NEWUSER=${OPTARG};; # Le nom de l'utilisateur qu'on veut ajouter
		a) ADMIN=${OPTARG};;   # L'utilisateur est-il admin du projet ? (O ou N)
	esac
done

if [ ! -z "$CLIENT"  ] && [ ! -z "$PROJECT " ] && [ ! -z "$NEWUSER" ] && [ ! -z "$ADMIN" ] # On vérifie si les parametres sont vides
then
	cd /disk2/clients/$CLIENT/$PROJECT

        if [[ $ADMIN =~ ^[Oo]$ ]]
        then
            echo "admin	$NEWUSER " >> .project-config
        else
            echo "user	$NEWUSER " >> .project-config
        fi
        echo -e "\nUtilisateur '$NEWUSER' ajoute au projet '$PROJECT'"

else #Si il y a un des parametres qui est vide
	/usr/local/bin/.gestionScripts/accueil.sh
	cd /disk2/clients

	$CLIENT = ""

	until [[ -d "$CLIENT" ]]
	do
		/usr/local/bin/.gestionScripts/accueil.sh
	        echo -e "\nChoisissez un client\n"

        	ls -1

	        echo -e "\n"
        	read -p "Votre choix : " CLIENT

        	if [[ ! -d "$CLIENT" ]]; then
              	read -p "Le client que vous avez entr� n'existe pas. Appuyez sur entrer pour continuer ..."
        	fi
	done

	cd $CLIENT

	FLAG_FOUND=false

	while [[ "$FLAG_FOUND" = false ]]
	do
		/usr/local/bin/.gestionScripts/accueil.sh
	        echo -e "\nParmi les projets suivants, veuillez entrer le nom du projet que vous voulez: \n"

		ls -1

		echo -e "\n"
        	read PROJECT

       		if [[ -d "$PROJECT" ]]
        	then
                	FLAG_FOUND=true
        	else
			read -p "Le projet n'existe pas. Veuillez entrer le nom d'un projet qui existe. Appuyez sur enter pour continuer ..."
        	fi
	done

	cd $PROJECT

	FLAG_EXISTS=false

	while [[ "$FLAG_EXISTS" = false ]]
	do
		/usr/local/bin/.gestionScripts/accueil.sh
		echo -e "\nVeuillez entrer le nom de l'utilisateur que vous voulez ajouter au projet '$PROJECT': "
		read NEWUSER

		if getent passwd $NEWUSER > /dev/null 2>&1 #Verification si l'utilisateur existe
		then
			FLAG_EXISTS=true
		else
			read -p "L'utilisateur n'existe pas. Veuillez entrer un utilisateur existant. Appuyez sur une touche pour continuer ..."
		fi
	done

	# On fait le lien avec le projet dans le home du user
	if ! [ -f "/home/$NEWUSER/$PROJECT" ]
	then
		mkdir /disk2/clients/$CLIENT/$PROJECT /home/$NEWUSER/$PROJECT
		mount --bind /disk2/clients/$CLIENT/$PROJECT /home/$NEWUSER/$PROJECT
	fi

	/usr/local/bin/.gestionScripts/accueil.sh
	read -p "L'utilisateur est-il administrateur du projet '$PROJECT' ? (O/N):" REPONSE #Oui ou non

	if [[ $REPONSE =~ ^[Oo]$ ]]
	then
		echo "admin	$NEWUSER " >> .project-config
	else
		echo "user	$NEWUSER " >> .project-config
	fi

	/usr/local/bin/.gestionScripts/droitsMultiple.sh /disk2/clients/$CLIENT/$PROJECT 

	echo -e "\nUtilisateur '$NEWUSER' ajoute au projet '$PROJECT'"
fi
