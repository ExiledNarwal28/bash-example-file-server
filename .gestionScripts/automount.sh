#!/bin/bash

# Check all client paths
for FILE in $(find /disk2/clients -name '.project-config'); do
    DIR=$(dirname $FILE)
    CLIENT=$(echo $DIR | cut -f4 -d/)
    PROJECT=$(echo $DIR | cut -f5 -d/)

    # Read each lines of project-config to check all users
    while IFS='' read -r line || [[ -n "$line" ]]; do
        USERNAME=$(echo $line | cut -f2 -d\ )
        HOME_DIRNAME=/home/$USERNAME/$PROJECT

        # Create a new directory on the home of the user
        if ! [ -d $HOME_DIRNAME ]; then
            mkdir $HOME_DIRNAME
        fi

        # Mount the project path
        mount --bind $DIR $HOME_DIRNAME
    done < "$FILE"
done
