#!/bin/bash

#Checking if home folders exist
if [[ ! -d "/home/admin" ]]; then
    echo "Home directory '/home/admin' does not exist."
    sudo mkdir -p "/home/admin"
    sudo chown root:root "/home/admin"
    sudo chmod 755 "/home/admin"
    echo "Home directory '/home/admin' created."
fi

if [[ ! -d "/home/moderator" ]]; then
    echo "Home directory '/home/moderator' does not exist."
    sudo mkdir -p "/home/moderator"
    sudo chown root:root "/home/moderator"
    sudo chmod 755 "/home/moderator"
    echo "Home directory '/home/moderator' created."
fi

if [[ ! -d "/home/student" ]]; then
    echo "Home directory '/home/student' does not exist."
    sudo mkdir -p "/home/student"
    sudo chown root:root "/home/student"
    sudo chmod 755 "/home/student"
    echo "Home directory '/home/student' created."
fi

echo "User Adding"
echo "------------"

while true; do
    #User input
    read -p "Enter the username: " NAME
    read -sp "Enter the user's password: " PASS
    read -rp $'\nEnter the user role (admin, moderator, student): ' ROLE
    #Checking if user exists
    if [[ -f "/home/$NAME" ]]; then
        echo "-------------------------------------------------------"
        echo "User $NAME already exists."
        echo "-------------------------------------------------------"
        continue
    #Checking if the role is written correctly
    elif [[ "$ROLE" != "admin" && "$ROLE" != "moderator" && "$ROLE" != "student" ]]; then
        echo "-------------------------------------------------------"
        echo "Role: $ROLE does not exist."
        echo "-------------------------------------------------------"
        continue
    else
        #Checking if there is user with same name and role
        if [[ -f "/home/$ROLE/$NAME" ]]; then
            echo "-------------------------------------------------------"
            echo "User $NAME already exists in the $ROLE role."
            echo "-------------------------------------------------------"
            continue
        fi
        #Creating user with main group admin||moderator||student into home directory with same name
        sudo useradd -md "/home/$ROLE/$NAME" -p $(openssl passwd -1 "$PASS") -s /bin/bash -N "$NAME"
        sudo usermod -g "$ROLE" "$NAME"
        sudo chown "$NAME:$ROLE" "/home/$ROLE/$NAME"
        #The user must change the password when logging in for the first time
        sudo chage -d 0 "$NAME"

        echo "-------------------------------------------------------"
        echo "Added user: $NAME"
        echo "-------------------------------------------------------"
    fi
done
