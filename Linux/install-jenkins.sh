#!/bin/sh

# Instalacion de Jenkins en Ubuntu
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

# Instalacion de Java necesario para Jenkins en Ubuntu
sudo apt update
sudo apt install fontconfig openjdk-17-jre
sudo apt install openjdk-17-jdk-headless
java -version