#!/bin/bash
cd /home/azureuser/Cloud-1
touch .gitignore
printf "./db_data\n./wordpress_data"
git pull
./deploy.sh