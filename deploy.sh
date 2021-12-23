if ! command -v docker &> /dev/null
then
    echo "docker could not be found. installing Docker"
    sudo apt-get update
    sudo apt-get install -y curl
    curl -fsSL get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo ""
    sleep 15
    cp ./update.sh /
    printf "\n@reboot /update.sh\n" > /etc/crontab
fi

function run {
    if ! docker info 2>/dev/null
    then
        sleep 5
        run
    else
        sudo docker-compose up
    fi
}