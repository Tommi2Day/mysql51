# mysql51

[![Docker Pulls](https://img.shields.io/docker/pulls/tommi2day/mysql51.svg)](https://hub.docker.com/r/tommi2day/mysql51/)

## A Mysql5.1 installation running on Docker
In 2024 when Mysql 8.3 ist current, a MySQL5.1 environment is still needed as requirement from mature programs 

### build
```sh
docker build -t tommi2day/mysql51 .
```
### exposed Ports
```sh
# mysql  
EXPOSE 3306
```
### expected share
```sh
/db # mysql datadir
```

### Environment variables used
```sh
MYSQL_ROOT_PASSWORD=mysql51
TZ=Europe/Berlin
```
Root password will be bound to the wildcard % host to allow login from any network host.

### Run
Specify the MYSQL_ROOT_PASSWORD environment variable and a volume 
for the datafiles when launching a new container, e.g:

```sh
docker run --name mysql51 \
--add-host="mysql51:127.0.0.1" \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \ 
-v /docker/mysql51-data:/db \ 
-p 33306:3306 \
tommi2day/mysql51
```

### Connect to mysql
```sh
mysql -h localhost -P 33306 -u root --password=$MYSQL_ROOT_PASSWORD mysql
```

### Source Repo
[github.com/Tommi2Day/mysql51](https://github.com/Tommi2Day/mysql51)