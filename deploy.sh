if ! command -v docker &> /dev/null
then
    echo "docker could not be found. installing Docker"
    sudo apt-get update
    sudo apt-get install -y curl
    curl -fsSL get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo ""
    sleep 15
    sudo cp ./update.sh /
    sudo printf "\n@reboot /update.sh\n" > /etc/crontab
    run()
else
    echo "docker already installed"
    run()
fi

function run {
    if ! docker info 2>/dev/null
    then
        echo "docker not ready waiting 5s"
        sleep 5
        run()
    else
        sudo docker-compose up &
    fi
}