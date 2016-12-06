#!bin/bash


#       *********************************************
#       *  Se script sert à modifier les droits des *
#       *  utilisateurs dans le fichier .config du  *
#       *  projet de facon récursive et automatique *
#       *********************************************

# Packet utilisé: acl (apt-get install acl)

# Script pour géré les droits d'utilisateur dans un fichier
# Créer par Pierre-Luc Gagnon
# Dernière modification le 2016-11-17

# String GET_LINE - contient la ligne actuelle selon le COUNTeur, du fichier .config
# String GET_RIGHTS - contient le droits d'un utilisateur du fichier .config, selon le COUNTeur
# String GET_LOGIN - contient le login de l'utilisateur du fichier .config, selon le COUNTeur

# Int COUNT - COUNTeur pour lire le fichier ligne par ligne

# Compte le nombre de ligne dans le .config

PROJECT=$1

LINES_NO=$( wc -l < $PROJECT/.project-config ) #Lis le nombre de ligne dans le fichier
COUNT=1

while [ "$COUNT" -le "$LINES_NO" ]
do


    # Sed -n (enleve le pattern de sepparateur par défault pour mettre lui qui est dans le fichier
    # 2 (ligne 2) p (imprime la ligne) q (arrete de lire à la fin de la ligne)
    # TODO: À implémanter le Path dynamiquement
    GET_LINE=$(sed -n "$COUNT{p;q;}" $PROJECT/.project-config)


    #Mets dans getDroits la valeur de la premiere colone de getLigne
    GET_RIGHTS=$(echo $GET_LINE | awk '{print $1;}') #Va chercher le droit dans la ligne
    GET_LOGIN=$(echo $GET_LINE | awk '{print $2;}') #Va chercher le login de l'utilisateur



    if [ $GET_RIGHTS = "admin" ]
    then
	    # Acces list
	    # R = récursif m = ignore les masque et droits actuelle
	    # u = (Utilisateur) :(Droit en RWX) (Répertoire)
	    # -m = Option pour modifier l'ACL existant sur le fichier
	    # TODO: À implémanter le Path dynamiquement
	    setfacl -Rm u:$GET_LOGIN:rwx $PROJECT

    else [ $GET_RIGHTS = "user" ]
	    # TODO: À implémanter le Path dynamiquement
	    setfacl -Rm u:$GET_LOGIN:rx $PROJECT
    fi

    setlfacl -m u:$GET_LOGIN:x $PROJECT/.project-config #enleve les droit sur .projectconfig
    ((COUNT++))
done
