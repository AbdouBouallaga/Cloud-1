docker rm -f -v cloud_phpmyadmin
docker rm -f -v cloud_wordpress
docker rm -f -v cloud_mysql
docker build -t cloud-1_pma:1 ./pma
docker build -t cloud-1_wordpress:1 ./wp
docker build -t cloud-1_mysql:1 ./db
docker network create --subnet=172.180.0.0/16 cloud-1_net
docker run --net cloud-1_net --ip 172.180.0.2 -d -p 127.0.0.1:3306:3306 --name cloud_mysql cloud-1_mysql:1
docker run --net cloud-1_net --ip 172.180.0.3 -d -p 80:80 -p 443:443 --name cloud_wordpress cloud-1_wordpress:1
docker run --net cloud-1_net --ip 172.180.0.4 -d -p 8080:80 --name cloud_phpmyadmin cloud-1_pma:1
