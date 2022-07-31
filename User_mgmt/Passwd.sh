#/bin/bash

clear

echo "Create multiple users using bash script."

while true
do
   read -p "Provide Username: " user
   if [ "$user" = "exit" ];
   then 
      break
   else
      useradd $user
      echo "$user is Created successfully"
      echo @!$Username#123@! | passwd --stdin $user
      echo "Default Password of $user is '@!$user#123@!' "
   fi
done