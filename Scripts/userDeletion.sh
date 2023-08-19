#!/bin/bash

#Checking for Available users and printing them on screen
echo "----------"
echo "Available users"
echo "----------"

cat /etc/passwd | grep /bin/bash | cut -d ':' -f1 | grep -v root
echo "----------"

#User deletion
while true; do
        read -p "Enter the user you want to delete: " NAME
        sudo userdel -r "$NAME"
        echo "User $NAME deleted"
        echo "----------"
done