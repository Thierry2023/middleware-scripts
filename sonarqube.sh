#!/bin/bash
#Author : Thierry
#Date : Fev, 11-2023
#Script of sonarqube installation

user_name=`whoami`

If [ $user_name != vagrant]
 then 
 echo "Must be a vagrant user to run !!!!"

echo "Java 11 installation"

sudo yum update -y

sleep 2

sudo yum install java-11-openjdk-devel -y

if [ $? -eq 0 ]
        then
        echo "installation java-11-openjdk-devel done successfully"
else
        echo "java-11-openjdk-devel did not install"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

sudo yum install java-11-openjdk -y

if [ $? -eq 0 ]
        then
 echo "install java-11-openjdk done successfully"
else
        echo "install java-11-openjdk did not install"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "Download SonarQube latest versions on your server ongoing"

echo "We move in opt directory"

sleep 2

cd /opt

echo "installation of wget"

sudo yum install wget -y

if [ $? -eq 0 ]
        then
        echo "install of wget done successfully"
else
        echo "wget did not install"
        echo "check the problem, solve it and restart the script"
        exit
		fi

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip

if [ $? -eq 0 ]
        then
        echo "Download SonarQube latest versions done successfully"
else
        echo "Download SonarQube latest versions did not install"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "Extract packages"

sudo yum install unzip

if [ $? -eq 0 ]
        then
        echo "Unzip done successfully"
else
        echo "Unzip did not install"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

sudo unzip /opt/sonarqube-9.3.0.51899.zip

if [ $? -eq 0 ]
        then
        echo "Unzip done successfully"
else
        echo "Unzip did not done "
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "Change ownership to the user and Switch to Linux binaries directory to start service"

sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899

if [ $? -eq 0 ]
        then
        echo "Change owner and the group done successfully"
else
        echo "Change owner and the group did not done"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "Switch to Linux binaries directory to start service"

cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64

if [ $? -eq 0 ]
        then
        echo "switch done successfully"
else
        echo "switch did not done "
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "Start of service"

 ./sonar.sh start

if [ $? -eq 0 ]
        then
        echo "Start done successfully"
else
        echo "Start did not done"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "activation of firewall and the port"

sudo firewall-cmd --permanent --add-port=9000/tcp

if [ $? -eq 0 ]
        then
        echo "Add port done successfully"
else
        echo "Add port did not done"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

sudo firewall-cmd --reload

if [ $? -eq 0 ]
        then
        echo "Firewall reload done successfully"
else
        echo "Firewall reload did not done"
        echo "check the problem, solve it and restart the script"
        exit
fi

sleep 2

echo "type your IP address in your browser and get access to sonarqube"