docker rm -f -v cloud_phpmyadmin
docker rm -f -v cloud_wordpress
docker rm -f -v cloud_mysql
docker build -t cloud-1_pma:1 ./pma
docker build -t cloud-1_wordpress:1 ./wp
docker build -t cloud-1_mysql:1 ./db
docker network create --subnet=172.180.0.0/16 cloud-1_net

# docker run --name mysql-cont -e MYSQL_ROOT_PASSWORD=toor -d mysql:5.7
# docker run --name cloud_wordpress --link mysql-cont:mysql -p 80:80 -d cloud-1_wordpress:1
# docker run -d -p 8080:80 --name cloud-1_phpmyadmin --link mysql-cont:mysql cloud-1_pma:1
docker run --net cloud-1_net --ip 172.180.0.2 -d -p 127.0.0.1:3306:3306 --name cloud_mysql cloud-1_mysql:1
docker run --net cloud-1_net --ip 172.180.0.3 -d -p 80:80 -p 443:443 --name cloud_wordpress cloud-1_wordpress:1
docker run --net cloud-1_net --ip 172.180.0.4 -d -p 8080:80 --name cloud_phpmyadmin cloud-1_pma:1
# docker run -d -p 80:80 --name cloud-1_wordpress --network cloud-1_net cloud-1_wordpress:1

# docker network create -d bridge cloud-1_net
# docker network connect cloud-1_net cloud-1_mysql
# docker network connect cloud-1_net cloud-1_wordpress
# docker network connect cloud-1_net cloud-1_phpmyadmin