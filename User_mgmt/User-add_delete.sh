1#/bin/bash 

clear

echo "Create or Delete Users using one script"

while true 
do 
  echo "[A] create         [B] delete        [C] exit"
  read -p "Selete optation to create/delete user: " option
  if [ "$option" = "create" ] || [ "$option" = "A" ];
  then
    while true
    do 
      read -p "Provide Username: " user
      if [ "$user" = "exit" ]
      then 
        break
      elif [ "$user" = "$(cat /etc/passwd | cut -d':' -f1 | grep -i ^$user$)" ];
      then
        echo "This user is already available"

      elif [ "$user" != "$(cat /etc/passwd | cut -d':' -f1 | grep -i ^$user$)" ];
      then
        useradd $user
        echo "$user has been creatded successfully."
        echo "!#@$user@123" | passwd --stdin $user
        echo "Default password of $user is '!#@$user@123' "
      fi
    done

  elif [ "$option" = "delete" ] || [ "$option" = "B" ];
  then

    while true
    do 
      read -p "Provide Username: " del
      if [ "$del" = "$(cat /etc/passwd | cut -d':' -f1 | grep -i ^$del$)" ];
      then 
        userdel $del
        echo "$del has been deleted successfully." 

      elif [ "$del" = "exit" ];
      then
        break
      
      elif [ "$del" != "$(cat /etc/passwd | cut -d':' -f1 | grep -i ^$del$)" ];
      then 
        echo "Please Provide Right Username"
      fi
    done

  elif [ "$option" = "exit" ] || [ "$option" = "C" ];
  then
    echo "Thank you to using this script."
    break
 
  else
    echo "Please select right optation"
    continue
  fi 
done