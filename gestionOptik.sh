
# !/bin/bash

# Menu pour les employés d'Optik 360
# William Leblanc
# Ce script affiche l'interface utilisé par les employés d'Optik 360

# La valeur par defaut est de "1".

REPONSE="1"

# Boucle "while" qui s'arrête seulement lorsque l'option "Quitter" est selectionnée.

while [ "$REPONSE" -ne "0" ]; do

# Efface l'écran avant d'afficher le menu, pour garder l'invite de commande lisible.

	clear

	echo "Menu de gestion - Optik 360"

# Les echo vides servent à sauter des lignes.

	echo ""

	echo "1) Ajouter un répertoire client"
	echo "2) Ajouter un répertoire projet"
	echo "3) Ajouter un utilisateur / administrateur"

	echo ""

	# Changer le nom de "suppressionUtilisateurProjet" pour "retirerMembreProjet".
	echo "4) Retirer  un utilisateur / administrateur d'un projet"

	echo ""

	echo "0) Quitter"

	echo ""
	echo ""

# REPONSE est lu de nouveau  jusqua ce que l'utilisateur quitte.

	read REPONSE

# "case" qui gère le choix saisie par l'utilisateur.

         case $REPONSE in

	    # Ajouter un répertoire client
	    "1")
		echo "Opt 1"

		bash /home/optik360/ScriptsBash/Interface/creationRepertoireClient

		break
		;;

	    # Ajouter un répertoire projet
	    "2")
		echo "Opt 2"

		bash /home/optik360/ScriptsBash/Interface/creationRepertoireDansClient

		break
		;;


	    # Ajouter un utilisateur / admin
	    "3")
		echo "Opt 3"

		bash /home/optik360/ScriptsBash/Interface/ajoutUtilisateurProjectConfig

		break
		;;

	    # Retirer un utilisateur / administrateur d'un projet
	    "4")
		echo "Opt 4"

		bash /home/optik360/ScriptsBash/Interface/suppressionUtilisateurProjet


		break
		;;


	    # Le break cause la fin du "case". Le "while" prend fin aussi puisque "0" a été saisie.
            "0")
		break
		;;

	    # si une autre réponse est saisie, un message d'erreur s'affiche.

	    *) echo invalid option;;


	    # "esac" ("case" à l'envers) sert à mettre fin au "case".
	    esac

# Fin du "while" (et du script)

done
