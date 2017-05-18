# Bash example : File server management #

This is a college project made by a team of 5 students. The goal was to make scripts to aid a local enterprise hosting files for specific clients. Scripts mostly organise files and directory. They also setup users and file rights.

There is a hell lot of French in there. This is because our college required it. Sorry. I will translate anything necessary if asked.

## Directories ##

Each client has a specific directory. Inside each client directory lies project directories. That's where the files are. So basically : 

        Client-A/Project-A/...
        Client-A/Project-B/...
        Client-B/...

## Users ##

Bash scripts help the enterprise (hosting files) creating users. Users are associated to project directories. It is also possible to set "administrator" users for each project. The "administrator" users will be able to set rights for files and directories within the project directory.

## Files ##

Main files are gestionAdmin.sh and gestionOptik.sh. The first is a script to be used by "administrators" of a project directory to set file rights to other users of the project directory. The second is a script to be used by the enterprise. It helps creating client and project directories, as well as users.

## How to use? ##

Put scripts in /usr/local/bin.

We suggest using aliases for gestionAdmin.sh and gestionOptik.sh.

Also, both scripts should have proper permissions.
