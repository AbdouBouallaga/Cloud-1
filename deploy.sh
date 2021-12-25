#!/bin/bash

function run {
	if ! sudo docker info 2>/dev/null
	then
		echo "docker not ready waiting 5s"
		sleep 5
		run
	else
		echo "docker ready"
	fi
	fi
}

if ! command -v docker &> /dev/null
then
	echo "docker could not be found. installing Docker"
	sudo apt-get update
	sudo apt-get install -y curl
	curl -fsSL get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
    sudo apt install -y docker-compose
	sudo cp ./update.sh /
    sudo chmod 666 /etc/crontab
	sudo printf "\n@reboot /update.sh\n" >> /etc/crontab
    sudo chmod 664 /etc/crontab
	run
else
	echo "docker already installed"
	run
fi
