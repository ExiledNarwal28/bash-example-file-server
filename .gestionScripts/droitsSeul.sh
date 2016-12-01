#!/bin/bash

#	*********************************************
#	*  Se script sert à modifier les droit d'un *
#	*  utilisateur pour un dossier ou fichier   *
#	*  spécifique.				    *
#	*********************************************

# Packet utilisé: acl (apt-get intall acl)

#Script de gestion d'utilisateur
#Créer par Pierre-Luc Gagnon
#Dernière modification le 2016-12-01

#Variables

#String loginUtilisateur - Contient le login de l'utilisateur
#String cheminFichier - Contient le chemin vers le fichier a changer les droits
#String getLigne - Contient la ligne (selon le compteur) du fichier .config
#String getDroits - Contient le droit (admin/user) pour vérification
#String choixDroit - Contient le nouveau droit de l'utilisateur
#String choixR/W/X - contient la réponse de l'utilisateur O/N si il confirme la modification des droit RWX

#Int nbLignes - Contien le nombre de ligne qui a dans le fichier .config
#Int Compteur - C'est un compteur pour la boucle while
#Int compteur2 - c'est le 2iem compteur pour une 2iem boucle
#Compte le nombre de ligne dans le fichier

# TODO À implémanter le Path d une façon dynamique
nbLigne=$( wc -l < /disk2/clients/client_shamwow/projet_prod/.project-config )

while getopts c: option
do
	case "${option}"
	in

	    c) cheminFichier=${OPTARG};; #chemin vers le fichier/dossier
	esac
done


choixDroits=""
compteur="1"

clear
echo -e "Menu Principal (Ctrl+C pour quitter)\n"

echo -e "Modifier les droits pour les fichiers et dossier\n"
echo -e "Utilisateurs dans le projet: \n"

while [ "$compteur" -le "$nbLigne"  ]
do
    #Lis le fichier ligne par ligne (Avec séparateur [TAB])
    #TODO À implémanter le Path dynamiquement
    getLigne=$(sed -n "$compteur{p;q;}" /disk2/clients/client_shamwow/projet_prod/.project-config)
    #Écris la deuxième colone de getLigne (Possible avec le séparateur [TAB])
    echo $getLigne | awk '{print $2;}'

    (( compteur++ ))
done



read -p "Entrez le login de l'utilisateur à modifier: " loginUtilisateur

# TODO vérifier si l'utilisateur en question est un user et non un admin (Non fonctionnel/Non fini)
#compteur2=1
#while [ "$compteur2" -le "$nbLigne" ]
#do
#Lis le fichier ligne par ligne
# TODO À implémenter le Path dynamiquement
#getLigne=$(sed -n "$compteur2{p;q;}" /disk2/clients/client_shamwow/projet_prod/.project-config)

#getDroits=$(echo $getLigne | awk '{print $1;}')

#if (

#(( compteur2++ ))
#done

#if [ $getDroits -eq "user"  ]
#then
    #Vérifie si l'utilisteur existe
    #TODO: modifier pour vérifier si l'utilisateur est dans le .project-config
    if [ -z "$(getent passwd $loginUtilisateur)"  ]
    then

        read -p "Nom d'utilisateur non valide! Appuyez sur 'Enter' pour continuer"

    else

        if [ -z  $cheminFichier ]
        then
            read -p "Entrez le chemin du fichier ou dossier à changer le droit: " cheminFichier
            #Vérifie si le fichier/Dossier existe
        fi

        if [ -d "$cheminFichier" ] || [ -f "$cheminFichier" ]
        then

            read -p "Voulez-vous donner le droit de lecture ? O/N: " choixR

            if [ "$choixR" = "O" ] || [ "$choixR" = "o" ]
            then

                choixDroits="r"

            fi

            read -p "Voulez-vous donner le droit d'écriture ? O/N: " choixW

            if [ "$choixW" = "O" ] || [ "$choixW" = "o" ]
            then

                choixDroits="$choixDroits""w"
            fi

            read -p "Voulez-vous donner le droit d'exécution ? O/N: " choixX

            if [ "$choixX" = "O" ] || [ "$choixX" = "o" ]
            then

                choixDroits="$choixDroits""x"

            fi

            if [ -d "$cheminFichier" ]
            then

                read -p "Voulez-vous attribuer ces même droits à tout les fichiers à l'intérieur de ce dossier?" choixON

      	        if [ $choixON = "o" ] || [ $choixON = "O" ]
	              then

                    #Set les droit sur le fichier ou dossier spécifier pour l'utilisateur spécifier
                    #u: (Utilistateur): Droits(RWX) chemin du fichier
                    # -m = option de modifier l'ACL existant sur le fichier

	                  setfacl -Rm u:$loginUtilisateur:$choixDroits $cheminFichier

                else

	                  setfacl -m u:$loginUtilisateur:$choixDroits $cheminFichier

	              fi

	          else

                setfacl -m u:$loginUtilisateur:$choixDroits $cheminFichier

	          fi

            read -p "Les droits du fichier/dossier ont été changer! Appuyez sur 'Enter' pour continuer"

        else

            read -p "Le fichier ou dossier n'existe pas! Appuyez sur 'Enter' pour continuer"

        fi
    fi
#fi

