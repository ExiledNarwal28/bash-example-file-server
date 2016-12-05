#!/bin/bash

#	*********************************************
#	*  Se script sert à modifier les droit d'un *
#	*  utilisateur pour un dossier ou fichier   *
#	*  spécifique.				    *
#	*********************************************

# Packet utilisé: acl (apt-get intall acl)

# Script de gestion d'utilisateur
# Créer par Pierre-Luc Gagnon
# Dernière modification le 2016-12-01

# Variables

# String USER_LOGINUser - Contient le USER_LOGIN de l'utilisateur
# String FILE_PATH - Contient le chemin vers le fichier a changer les droits
# String getLine - Contient la ligne (selon le COUNTeur) du fichier .config
# String getRights - Contient le droit (admin/user) pour vérification
# String RIGHTS_CHOICE - Contient le nouveau droit de l'utilisateur
# String RIGHTS_CHOICE_R/W/X - contient la réponse de l'utilisateur O/N si il confirme la modification des droit RWX

# Int LINE_NOs - Contien le nombre de ligne qui a dans le fichier .config
# Int COUNT - C'est un COUNTeur pour la boucle while
# Int COUNT2 - c'est le 2iem COUNTeur pour une 2iem boucle
# Compte le nombre de ligne dans le fichier

PROJECT=$1 # path vers le PROJECT
FILE_PATH=$2 # chemin vers le fichier/dossier

LINE_NO=$( wc -l < "$PROJECT/.PROJECT-config" )

RIGHTS_CHOICE=""
COUNT=1

clear
echo -e "Menu Principal (Ctrl+C pour quitter)\n"

echo -e "Modifier les droits pour les fichiers et dossier\n"
echo -e "Utilisateurs dans le projet: \n"

while [[ $COUNT -le $LINE_NO  ]]
do
    # Lis le fichier ligne par ligne (Avec séparateur [TAB])
    # TODO À implémanter le Path dynamiquement
    GET_LINE=$(sed -n "$COUNTeur{p;q;}" $PROJECT/.PROJECT-config)
    # Écris la deuxième colone de GET_LINE (Possible avec le séparateur [TAB])
    echo $getLine | awk '{print $2;}'

    (( COUNT++ ))
done



read -p "Entrez le USER_LOGIN de l'utilisateur à modifier: " USER_LOGIN

# TODO vérifier si l'utilisateur en question est un user et non un admin (Non fonctionnel/Non fini)
# COUNTeur2=1
# while [ "$COUNT2" -le "$LINE_NO" ]
# do
# Lis le fichier ligne par ligne
# TODO À implémenter le Path dynamiquement
# GET_LINE=$(sed -n "$COUNT2{p;q;}" /disk2/clients/client_shamwow/projet_prod/.PROJECT-config)

# getDroits=$(echo $GET_LINE | awk '{print $1;}')

# if (

# (( COUNTeur2++ ))
# done

# if [ $getDroits -eq "user"  ]
# then
    # Vérifie si l'utilisteur existe
    # TODO: modifier pour vérifier si l'utilisateur est dans le .PROJECT-config
    if [ -z "$(getent passwd $USER_LOGIN)"  ]
    then

        read -p "Nom d'utilisateur non valide! Appuyez sur 'Enter' pour continuer"

    else

        if [ -z  $FILE_PATH ]
        then
            read -p "Entrez le chemin du fichier ou dossier à changer le droit: " FILE_PATH
            #Vérifie si le fichier/Dossier existe
        fi

        if [ -d "$FILE_PATH" ] || [ -f "$FILE_PATH" ]
        then

            read -p "Voulez-vous donner le droit de lecture ? O/N: " RIGHTS_CHOICE_R

            if [ "$RIGHTS_CHOICE_R" = "O" ] || [ "$RIGHTS_CHOICE_R" = "o" ]
            then
                RIGHTS_CHOICE="r"
            fi

            read -p "Voulez-vous donner le droit d'écriture ? O/N: " RIGHTS_CHOICE_W

            if [ "$RIGHTS_CHOICE_W" = "O" ] || [ "$RIGHTS_CHOICE_W" = "o" ]
            then
                RIGHTS_CHOICE="$RIGHTS_CHOICE""w"
            fi

            read -p "Voulez-vous donner le droit d'exécution ? O/N: " RIGHTS_CHOICE_X

            if [ "$RIGHTS_CHOICE_X" = "O" ] || [ "$RIGHTS_CHOICE_X" = "o" ]
            then
                RIGHTS_CHOICE="$RIGHTS_CHOICE""x"
            fi

            if [ -d "$FILE_PATH" ]
            then

                read -p "Voulez-vous attribuer ces même droits à tout les fichiers à l'intérieur de ce dossier?" ANSWER

      	        if [ $ANSWER = "o" ] || [ $ANSWER = "O" ]
	              then

                    # Set les droit sur le fichier ou dossier spécifier pour l'utilisateur spécifier
                    # u = (Utilistateur): Droits(RWX) chemin du fichier
                    # -m = option de modifier l'ACL existant sur le fichier

	                  setfacl -Rm u:$USER_LOGINUser:$RIGHTS_CHOICE $FILE_PATH

                else

	                  setfacl -m u:$USER_LOGINUser:$RIGHTS_CHOICE $FILE_PATH

	              fi

	          else

                setfacl -m u:$USER_LOGINUser:$RIGHTS_CHOICE $FILE_PATH

	          fi

            read -p "Les droits du fichier/dossier ont été changer! Appuyez sur 'Enter' pour continuer"

        else

            read -p "Le fichier ou dossier n'existe pas! Appuyez sur 'Enter' pour continuer"

        fi
    fi
#fi
