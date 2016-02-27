#!/usr/bin/env bash

case "$1" in
  create)
    docker-machine ls | grep -w docker > /dev/null
    if [ $? -ne 0 ];then
        docker-machine create --driver virtualbox docker
    else
        echo "docker is created"
    fi
    ;;
  update)
    docker-machine ls | grep -w docker > /dev/null
    if [ $? -ne 0 ];then
      echo "docker not exist"
    else
      docker-machine stop docker
      VBoxManage modifyvm "docker" --cpus 4
      VBoxManage modifyvm "docker" --cpuexecutioncap 80
      VBoxManage modifyvm "docker" --memory 2048
      VBoxManage modifyvm "docker" --natpf1 "mysql,tcp,,3306,,3306"
      VBoxManage modifyvm "docker" --natpf1 "postgres,tcp,,5432,,5432"
      VBoxManage modifyvm "docker" --natpf1 "mongo,tcp,,27017,,27017"
      VBoxManage modifyvm "docker" --natpf1 "elasticsearch-9300,tcp,,9300,,9300"
      VBoxManage modifyvm "docker" --natpf1 "elasticsearch-9200,tcp,,9200,,9200"
      VBoxManage modifyvm "docker" --natpf1 "redis,tcp,,6379,,6379"
      VBoxManage modifyvm "docker" --natpf1 "fluentd,tcp,,24224,,24224"
      VBoxManage modifyvm "docker" --natpf1 "nginx,tcp,,8080,,80"
      VBoxManage modifyvm "docker" --natpf1 "node,tcp,,3000,,3000"
      VBoxManage modifyvm "docker" --natpf1 "rails,tcp,,3001,,3001"
      docker-machine start docker
      echo "Run this command to configure your shell: "
      echo "eval \"\$(docker-machine env docker)\""
    fi
    ;;
  start)
    docker-machine start docker
    echo "Run this command to configure your shell: "
    echo "eval \"\$(docker-machine env docker)\""
    ;;
  stop)
    docker-machine stop docker
    ;;
  rm)
    docker-machine rm -f docker
    ;;
  backup)
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar cvf /backup/mongodb.tar /data
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar cvf /backup/mysql.tar /var/lib/mysql
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar cvf /backup/postgres.tar /var/lib/postgresql
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar cvf /backup/elasticsearch.tar /usr/share/elasticsearch
    ;;
  restore)
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar xvf /backup/mongodb.tar
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar xvf /backup/mysql.tar
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar xvf /backup/postgres.tar
    docker run --rm --volumes-from docker_data_1 -v $(pwd)/backup:/backup busybox tar xvf /backup/elasticsearch.tar
    ;;
  backup-gz)
    SAVE_DIR=${2:-"./backup"}
    FILE_NAME="backup"
    docker-machine ssh docker "sudo tar cvzf /tmp/snapshot.tar.gz /mnt/sda1/shared"
    docker-machine scp docker:/tmp/snapshot.tar.gz ${SAVE_DIR}/${FILE_NAME}.tar.gz
    ;;
  restore-gz)
    SAVE_DIR=${2:-"./backup"}
    FILE_NAME="backup"
    docker-machine scp ${SAVE_DIR}/${FILE_NAME}.tar.gz docker:/tmp/snapshot.tar.gz
    docker-machine ssh docker "sudo tar xvzf /tmp/snapshot.tar.gz -C /"
    ;;
  *)
    echo "./machine.sh (create | update | start | stop | rm | backup | restore)"
    ;;
esac
