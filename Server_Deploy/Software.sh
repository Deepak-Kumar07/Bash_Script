#/bin/bash
#Clear the Screen to Better experience
clear
#Store the Operating System Name in 'name' variable 
echo "Welcome to start using script to install Server Packages"
name=$(egrep '^(NAME)=' /etc/os-release | cut -d'=' -f2 | cut-d'"' -f2 | awk '{print $1}')
# Print Operating system to on onscreen
echo "Your Operating System is $name Linux"
#Using function to store multiple command.
function Ubuntu_Apache () {
  echo "Apache Server installation Start"
  sudo apt install apache2 -y
  sudo ufw allow 'apache2'
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
  sudo systemctl restart httpd
  sudo systemctl enable apache2
  echo "Apache Server installation has been completed"
}
function Ubuntu_Ftp () {
  echo "Ftp Server installation Start"
  sudo apt install vsftpd -y
  sudo ufw allow 20/tcp
  sudo ufw allow 21/tcp
  sudo systemctl restart vsftpd
  sudo systemctl enable vsftpd
  echo "Ftp Server installation has been completed"
}
function Ubuntu_Samba () {
  echo "Samba Server installation Start"
  sudo apt install samba -y
  sudo ufw allow 'samba'
  sudo systemctl restart samba
  sudo systemctl enable samba
  echo "Samba Server installation has been completed"
}
function Ubuntu_Nginx () {
  echo "Nginx Server installation Start"
  sudo apt-get install Nginx -y
  sudo systemctl start nginx
  sudo systemctl enable nginx
  sudo ufw allow 'nginx http'
  sudo ufw allow 'nginx https'
  sudo ufw allow 'nginx full'
  sudo ufe reload
  sudo systemctl restart nginx
  echo "Nginx Server installation has been completed"
}
function CentOS_Apache () {
  echo "Apache Server installation Start"
  sudo yum install httpd -y
  sudo systemctl enable httpd
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload
  sudo systemctl restart httpd
  echo "Apache Server installation has been completed"
}
function CentOS_Ftp () {
  echo "Ftp Server installation Start"
  sudo yum install vsftpd -y
  sudo systemctl enable vsftpd
  sudo firewall-cmd --permanent --zone=public --add-port=20/tcp
  sudo firewall-cmd --permanent --zone=public --add-port=21/tcp
  sudo firewall-cmd --reload
  sudo systemctl restart vsftpd
  echo "Ftp Server installation has been completed"
}
function CentOS_Samba () {
  echo "Samba Server installation Start"
  sudo dnf install samba samba-common samba-client -y
  sudo firewall-cmd --add-service=samba --zone=public --permanent
  sudo firewall-cmd --reload
  sudo systemctl start smb
  sudo systemctl enable smb
  echo "Samba Server installation has been completed"
}
function CentOS_Nginx () {
  echo "Nginx Server installation Start"
  sudo yum install nginx -y
  sudo firewall-cmd --permanent --zone=public --add-service=http --add-service=https
  sudo firewall-cmd --reload
  sudo systemctl enable Nginx
  sudo systemctl restart nginx
  echo "Nginx Server installation has been completed"
}
# To real thing from here
while true
do
  echo "[1] Apache    [2] Ftp    [3] Samba    [4] Nginx    [5] Exit"
  red -p "Provide Server name: " pkg

  if [ "$pkg" = "Apache" ] || [ "$pkg" = "1" ];
  then
      if [ "$name" = "Ubuntu" ] || [ "$name" = "Debian" ];
      then 
          Ubuntu_Apache
      elif [ "$name" = "Centos" ] || [ "$name" = "Rhel" ];
      then
          CentOS_Apache
      else 
          echo "This script is only Valid for Rhel/Centos/Ubuntu/Debian"
      fi
  elif [ "$pkg" = "Ftp" ] || [ "$pkg" = "2" ];
  then 
      if [ "$name" = "Ubuntu" ] || [ "$name" = "Debian" ];
      then 
          Ubuntu_Ftp
      elif [ "$name" = "Centos" ] || [ "$name" = "Rhel" ];
      then
          CentOS_Ftp
      else 
          echo "This script is only Valid for Rhel/Centos/Ubuntu/Debian"
      fi
  elif [ "$pkg" = "Sabma" ] || [ "$pkg" = "3" ];
  then 
      if [ "$name" = "Ubuntu" ] || [ "$name" = "Debian" ];
      then 
          Ubuntu_Samba
      elif [ "$name" = "Centos" ] || [ "$name" = "Rhel" ];
      then
          CentOS_Samba
      else 
          echo "This script is only Valid for Rhel/Centos/Ubuntu/Debian"
      fi
  elif [ "$pkg" = "Nginx" ] || [ "$pkg" = "4" ];
  then 
      if [ "$name" = "Ubuntu" ] || [ "$name" = "Debian" ];
      then 
          Ubuntu_Nginx
      elif [ "$name" = "Centos" ] || [ "$name" = "Rhel" ];
      then
          CentOS_Nginx
      else 
          echo "This script is only Valid for Rhel/Centos/Ubuntu/Debian"
      fi
  elif [ "$pkg" = "Exit" ] || [ "$pkg" = "5" ];
  then 
      echo "Thank You to using this scipt to installation Server. Have a nice day."
      break
  else 
      echo "Please select right Option like: 1 or Apache both are working same"
  fi
done
