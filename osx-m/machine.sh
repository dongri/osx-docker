#!/bin/bash

case "$1" in
  create)
    docker-machine ls | grep -w osx-m > /dev/null
    if [ $? -ne 0 ];then
        docker-machine create --driver virtualbox osx-m
    else
        echo "osx-m is created"
    fi
    ;;
  update)
    docker-machine ls | grep -w osx-m > /dev/null
    if [ $? -ne 0 ];then
      echo "osx-m not exist"
    else
      docker-machine stop osx-m
      VBoxManage modifyvm "osx-m" --memory 2048
      VBoxManage modifyvm "osx-m" --natpf1 "mysql,tcp,,3306,,3306"
      VBoxManage modifyvm "osx-m" --natpf1 "postgres,tcp,,5432,,5432"
      VBoxManage modifyvm "osx-m" --natpf1 "mongo,tcp,,27017,,27017"
      VBoxManage modifyvm "osx-m" --natpf1 "elasticsearch-9300,tcp,,9300,,9300"
      VBoxManage modifyvm "osx-m" --natpf1 "elasticsearch-9200,tcp,,9200,,9200"
      VBoxManage modifyvm "osx-m" --natpf1 "redis,tcp,,6379,,6379"
      VBoxManage modifyvm "osx-m" --natpf1 "fluentd,tcp,,24224,,24224"
      docker-machine start osx-m
      echo "Run this command to configure your shell: "
      echo "eval \"\$(docker-machine env osx-m)\""
    fi
    ;;
  start)
    docker-machine start osx-m
    echo "Run this command to configure your shell: "
    echo "eval \"\$(docker-machine env osx-m)\""
    ;;
  stop)
    docker-machine stop osx-m
    ;;
  rm)
    docker-machine rm -f osx-m
    ;;
  backup)
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar cvf /backup/mongodb.tar /data
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar cvf /backup/mysql.tar /var/lib/mysql
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar cvf /backup/postgres.tar /var/lib/postgresql
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar cvf /backup/elasticsearch.tar /usr/share/elasticsearch
    ;;
  restore)
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar xvf /backup/mongodb.tar
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar xvf /backup/mysql.tar
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar xvf /backup/postgres.tar
    docker run --rm --volumes-from osxm_data_1 -v $(pwd)/tar:/backup busybox tar xvf /backup/elasticsearch.tar
    ;;
  backup_gz)
    SAVE_DIR=${2:-"./"}
    FILE_NAME="backup"
    docker-machine ssh osx-m "sudo tar cvzf /tmp/snapshot.tar.gz /mnt/sda1/shared"
    docker-machine scp osx-m:/tmp/snapshot.tar.gz ${SAVE_DIR}/${FILE_NAME}.tar.gz
    ;;
  restore_gz)
    FILE_NAME="backup"
    docker-machine scp ${FILE_NAME}.tar.gz osx-m:/tmp/snapshot.tar.gz
    docker-machine ssh osx-m "sudo tar xvzf /tmp/snapshot.tar.gz -C /"
    ;;
  *)
    echo "./machine.sh (create | update | start | stop | rm | backup | restore)"
    ;;
esac
