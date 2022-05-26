## Docker commando's

van https://www.youtube.com/watch?v=fqMOX6JJhGo

### Docker uitvoeren & orchestreren

``docker run nginx`` : start een docker engine, als de image lokaal niet bestaat, dan  wordt deze gedownload. Container werkt op de voorgrond en terminal is niet meer beschikbaar voor andere dingen.

``docker run -d nginx`` : start een container in daemon mode bv. "docker run -d freqtradeorg/freqtrade"

``docker attach <(deel van) id>`` : Koppelen aan een daemonized container in de terminal.

``docker stop <id / name>`` : stop de container met de betreffende id.

``docker rm <id / name>`` : verwijder de gestopte container instance (elke keer als een container start wordt een nieuwe instance hiervan gemaakt).

``docker exec <id / name> <commando>`` : commando uitvoeren op een werkende container bv. "docker exec various_valve cat /etc/hosts" - toon hosts bestand in container various_valve.
Nb. OS images kunnen hiermee gebruikt worden om commano's uit te voeren. Als het commando klaar is, wordt de image gestopt. Bijv. "docker exec distractec_mcintlock cat /etc/hosts".

``docker-compose up`` : Starten van de container wanneer gebruik gemaakt wordt van een docker configuratie bestand "docker-compose.yml" (gebruik switch ``-d`` voor daemonizen).

``docker run <imagenaam>:<versiontag>`` : Een oudere versie van een bestaande container kun je starten met dit commando, bv. "docker run redis:4.0". Op dockerhub.com kun je bij elke software zien welke versies (tags) er bestaan.

``docker run -it <containernaam>``: Input leveren aan een docker container met een pseudo terminal. Docker werkt normaal in non-interactive mode, dwz. zonder te luisteren naar input (STDIN) en voert gecontaineriseerd het programma uit en toont output op het scherm (STDOUT). Met dit commando kun je wel input leveren bij het starten van de container.

``docker run -p 80:5000 <containernaam>`` : Port mapping / forwarding van een door docker geleverde service aan clients buiten de docker host. Dwz. Docker kent aan een interne service op poort 5000 een intern IP adres toe (bv. 172.16.1.23), dat door de buitenwereld niet is te benaderen. Door port forwarding te doen kan een externe client naar de docker host gaan op 192.168.1.245:80 en met dit commando wordt deze poort geforward naar de betreffende interne docker service op poort 5000.
Op deze manier kun je verschillende docker webservices hosten op verschillende poorten. 80:5000, 80:5001, 80:5002 etc.

``docker run -v <externe dir>:<interne dir> <containernaam>`` : Wanneer data opgeslagen wordt binnen de docker container, dan wordt deze gewist als de container wordt verwijderd. Met dit commando mount je een externe directory aan een interne docker directory zodat data extern blijft bewaard. Bijv. "docker run -v /opt/datadir:/var/lib/mysql mysql".

Onderstaande opties kunnen worden opgeslagen in een Docker compose bestand:

```
---
version: '3'
services:
  freqtrade:
    image: freqtradeorg/freqtrade:stable
    # image: freqtradeorg/freqtrade:develop
    # Use plotting image
    # image: freqtradeorg/freqtrade:develop_plot
    # Build step - only needed when additional dependencies are needed
    # build:
    #   context: .
    #   dockerfile: "./docker/Dockerfile.technical"
    restart: unless-stopped
    container_name: freqtrade
    volumes:
      - "./user_data:/freqtrade/user_data"
    # Default command used when running `docker compose up`
    command: >
      trade
      --logfile /freqtrade/user_data/logs/freqtrade.log
      --db-url sqlite:////freqtrade/user_data/tradesv3.sqlite
      --config /freqtrade/user_data/config.json
      --strategy AwesomeStrategy
```

``docker run -e APP_COLOR=blue simple-webapp-color`` : -e is een toekenning van een environment variable die je dient te gebruiken in de programmatuur. Deze environment variable is te achterhalen door de configfile van de container te bekijken (docker inspect container) en onder de sectie "Config" te vinden.

### Docker managen

``docker ps`` : toon alle werkende containers met naam, (random) id, status etc.

``docker ps -a`` : toon alle containers, of ze nu werken of niet.

``docker images`` : toon alle gedownloade images met grootte etc.

``docker rmi <imagenaam>`` : verwijder de gedownloade lokale image.

``docker inspect <containernaam / id>`` : Meer detail informatie ophalen van een container (JSON formaat).

``docker logs <containernaam / id>`` : Toon de logs van een daemonized docker container.

### Docker image maken & aanpassen

Voordat een Docker image gemaakt wordt, eerst indenken hoe een reguliere toepassing wordt gemaakt:

1. OS - Ubuntu
2. Update apt repo
3. Install dependencies using apt
4. Install Python dependencies using pip3
5. Copy source code to /opt folder
6. Run the program (e.g. web server using "flask")

Nu we dit weten, kunnen we een Dockerfile maken met de volgende content:

```
FROM Ubuntu

RUN apt-get update
RUN apt-get upgrade

RUN pip3 install flask
RUN pip3 install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask runz
```

### Docker backup


## Docker installeren
### Installeren van Docker op Linux Mint 20

```
sudo su

apt-get update

apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"

apt-get update

apt-get -y install docker-ce

# Once installed a docker group will be created. Add your user to the group who will be running docker commands.

sudo usermod -aG docker $USER

newgrp docker
```

``docker --version`` : Versie van Docker bekijken. Merk hierbij de Server OS/Arch op zoals linux/amd64. Deze zal alleen Linux containers kunnen uitvoeren.

``docker-compose --version``: Toon Docker compose versienummer.

``docker-machine --version``: Toon Docker machine versienummer.

### Installeren van Docker compose op Linux Mint

```
sudo su

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```

Some docker commands

```
docker help
```

Sample: Run NGINX with docker

```
docker pull nginx
docker images
docker run --name docker-nginx -p 80:80 nginx

# open your browser and enter http://localhost

docker ps
docker ps -a

docker stop <container-ID>
```

### Installeren van Docker op raspberri pi

Opposed to most other Linux distributions, Raspberry Pi is based on ARM architecture. Hence, not all Docker images will work on your Raspberry Pi.

In fact, all Docker images that are not specifically designed for ARM devices will not work. Running docker-apps designed for x86/x64 and i386 architecture on your Raspberry Pi will return an error.

Follow the commands to install Docker on a raspberri pi:

```
# Update and Upgrade

sudo apt-get update && sudo apt-get upgrade

# Download the Convenience Script and Install Docker on Raspberry Pi

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

# Add a Non-Root User to the Docker Group

sudo usermod -aG docker [user_name]

# e.g. sudo usermod -aG docker Pi

# Check Docker Version and Info

docker version

docker info

# Run Hello World Container

docker run hello-world

# Install Docker Compose

sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip

sudo pip3 install docker-compose

# Uninstall Docker on Your Raspberry Pi

sudo apt-get purge docker-ce

# delete leftover images, containers, volumes and other related data

sudo rm -rf /var/lib/docker

```

### User rechten probleem

Als normale gebruiker kreeg ik dit:

Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version: dial unix /var/run/docker.sock: connect: permission denied


To run the docker commands without sudo, you can add your user account (or the account you are trying to fix this problem for) to the docker group.

```
sudo groupadd docker
sudo usermod -aG docker $USER
groups
```

If you check your groups and docker groups is not listed 

```
newgrp docker
groups
```

Nu gaat het goed!

## Docker verwijderen

To completely uninstall Docker:

Step 1

```
dpkg -l | grep -i docker
```

To identify what installed package you have:

Step 2

```
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce  
```

The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following commands:

```
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
```

You have removed Docker from the system completely.
