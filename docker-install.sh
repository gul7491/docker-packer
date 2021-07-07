#!/bin/bash

echo "Installing docker"
sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install docker
sudo service docker start
#sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
#sudo apt update
#apt-cache policy docker-ce
#sudo apt install -y docker-ce
# sudo systemctl status docker
#sudo systemctl start docker
echo "$(docker --version)"
#DTR setup docker demon.json setup 

sudo systemctl start docker
sudo wget -c https://raw.githubusercontent.com/gul7491/docker-packer/main/demon -O /etc/docker/daemon1.json
cd /etc/docker
sudo  mv  -f daemon1.json  daemon.json
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
s=$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' registry)
sudo sed -i 's/172.0.0.0/'$s'/g' /etc/docker/daemon.json
sudo systemctl restart docker


docker tag hello-world 172.17.0.2:5000/hello-world 
curl -X GET http://172.17.0.2:5000/v2/_catalog
