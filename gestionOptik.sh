
# !/bin/bash

# Menu pour les employés d'Optik 360
# William Leblanc
# Ce script affiche l'interface utilisé par les employés d'Optik 360

# La valeur par defaut est de "1".

# Boucle "while" qui s'arrête seulement lorsque l'option "Quitter" est selectionnée.

while :
do

# Efface l'écran avant d'afficher le menu, pour garder l'invite de commande lisible.

	clear

	echo "Menu de gestion - Optik 360"

# Les echo vides servent à sauter des lignes.

	echo ""

	echo "1) Ajouter un répertoire client"
	echo "2) Ajouter un répertoire projet"
	echo "3) Ajouter un utilisateur / administrateur"
	echo "4) Retirer  un utilisateur / administrateur d'un projet" # Changer le nom de "suppressionUtilisateurProjet" pour "retirerMembreProjet".
	echo ""
	echo "0) Quitter"
	echo ""
# REPONSE est lu de nouveau  jusqua ce que l'utilisateur quitte.

	read -p "Votre choix : " REPONSE

# "case" qui gère le choix saisie par l'utilisateur.

         case $REPONSE in

	    # Ajouter un répertoire client
	    "1")
		/bin/bash /usr/local/bin/.gestionScripts/creationClient.sh
		;;

	    # Ajouter un répertoire projet
	    "2")
		/bin/bash /usr/local/bin/.gestionScripts/creationProjet.sh
		;;


	    # Ajouter un utilisateur / admin
	    "3")
		/bin/bash /usr/local/bin/.gestionScripts/ajoutUtilisateurProjet.sh
		;;

	    # Retirer un utilisateur / administrateur d'un projet
	    "4")
		/bin/bash /home/optik360/ScriptsBash/Interface/suppressionUtilisateurProjet.sh
		;;


	    # Le break cause la fin du "case". Le "while" prend fin aussi puisque "0" a été saisie.
            "0")
		exit
		;;

	    # si une autre réponse est saisie, un message d'erreur s'affiche.

	    *) 
		echo "Entrée invalide."
		;;


	    # "esac" ("case" à l'envers) sert à mettre fin au "case".
	    esac

# Fin du "while" (et du script)

done
