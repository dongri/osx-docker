#!/usr/bin/env bash

case "$1" in
  create)
    docker-machine ls | grep -w osx-a > /dev/null
    if [ $? -ne 0 ];then
        docker-machine create --driver virtualbox osx-a
    else
        echo "osx-a is created"
    fi
    ;;
  update)
    docker-machine ls | grep -w osx-a > /dev/null
    if [ $? -ne 0 ];then
      echo "osx-a not exist"
    else
      docker-machine stop osx-a
      VBoxManage modifyvm "osx-a" --cpus 4
      VBoxManage modifyvm "osx-a" --cpuexecutioncap 80
      VBoxManage modifyvm "osx-a" --memory 2048
      VBoxManage modifyvm "osx-a" --natpf1 "nginx,tcp,,8080,,80"
      VBoxManage modifyvm "osx-a" --natpf1 "node,tcp,,3000,,3000"
      docker-machine start osx-a
      echo "Run this command to configure your shell: "
      echo "eval \"\$(docker-machine env osx-a)\""
    fi
    ;;
  start)
    docker-machine start osx-a
    echo "Run this command to configure your shell: "
    echo "eval \"\$(docker-machine env osx-a)\""
    ;;
  stop)
    docker-machine stop osx-a
    ;;
  rm)
    docker-machine rm -f osx-a
    ;;
  *)
    echo "./machine.sh (create | update | start | stop | rm)"
    ;;
esac
