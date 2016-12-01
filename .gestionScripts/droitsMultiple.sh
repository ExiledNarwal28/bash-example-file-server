#!bin/bash


#       *********************************************
#       *  Se script sert à modifier les droits des *
#       *  utilisateurs dans le fichier .config du  *
#       *  projet de facon récursive et automatique *
#       *********************************************

# Packet utilisé: acl (apt-get install acl)

#Script pour géré les droits d'utilisateur dans un fichier
#Créer par Pierre-Luc Gagnon
#Dernière modification le 2016-11-17

#String getLigne - contient la ligne actuelle selon le compteur, du fichier .config
#String getDroits - contient le droits d'un utilisateur du fichier .config, selon le compteur
#String getLogin - contient le login de l'utilisateur du fichier .config, selon le compteur

#Int compteur - compteur pour lire le fichier ligne par ligne
#Int nombre de ligne dans le fichier .config où la modification de droits doit être fait

#Compte le nombre de ligne dans le .config

# TODO: À implémanter le Path  dynamiquement
nbLigne=$( wc -l < /disk2/clients/client_shamwow/projet_prod/.project-config )
compteur=1


while [ "$compteur" -le "$nbLigne" ]
do


    # Sed -n (enleve le pattern de sepparateur par défault pour mettre lui qui est dans le fichier
    # 2 (ligne 2) p (imprime la ligne) q (arrete de lire à la fin de la ligne)
    # TODO: À implémanter le Path dynamiquement
    getLigne=$(sed -n "$compteur{p;q;}" /disk2/clients/client_shamwow/projet_prod/.project-config)


    #Mets dans getDroits la valeur de la premiere colone de getLigne
    getDroits=$(echo $getLigne | awk '{print $1;}')
    getLogin=$(echo $getLigne | awk '{print $2;}')



    if [ $getDroits = "admin" ]
    then
	    #Acces list
	    #R = récursif m = ignore les masque et droits actuelle
	    #u: (Utilisateur) :(Droit en RWX) (Répertoire)
	    # -m = Option pour modifier l'ACL existant sur le fichier
	    # TODO: À implémanter le Path dynamiquement
	    setfacl -Rm u:$getLogin:rwx /disk2/clients/client_shamwow/projet_prod

    else [ $getDroits = "user" ]
	    # TODO: À implémanter le Path dynamiquement
	    setfacl -Rm u:$getLogin:rx /disk2/clients/client_shamwow/projet_prod
    fi

    setlfacl -m u:$getLogin:x /disk2/clients/client_shamwow/projet_prod
    ((compteur++))

done

