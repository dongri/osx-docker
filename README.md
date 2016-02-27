# Docker on OSX

Docker example for mac osx

# Install dockertoolbox

```
$ brew cask install dockertoolbox
```

# Docker

```
$ cd docker
$ ./machine.sh create
$ ./machine.sh update
$ eval "$(docker-machine env docker)"
$ docker-compose build
$ docker-compose start

$ docker-machine ssh docker          
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.10.2, build master : 611be10 - Mon Feb 22 22:47:06 UTC 2016
Docker version 1.10.2, build c3959b1
docker@docker:~$
```

# MySQL

```
$ docker-machine ssh docker

docker@docker:~$ docker ps
docker@docker:~$ docker exec -it e3a69abfa3a3 /bin/bash
root@e3a69abfa3a3:/# mysql -u root

mysql>
```

# PostgreSQL

```
$ docker-machine ssh docker

docker@docker:~$ docker ps
docker@docker:~$ docker exec -it dc5114934128 /bin/bash
root@dc5114934128:/# su - postgres
No directory, logging in with HOME=/
$ psql
psql (9.5.1)
Type "help" for help.

postgres=#
```

# Data Backup and Restore

```
$ docker-compose stop

$ ./machine.sh backup
$ ./machine.sh restore

$ ./machine.sh backup-gz
$ ./machine.sh restore-gz
```

# Apps

```
$ cd apps/rails
$ docker-compose up
rails_1 | [2016-02-27 05:38:57] INFO  WEBrick 1.3.1
rails_1 | [2016-02-27 05:38:57] INFO  ruby 2.2.4 (2015-12-16) [x86_64-linux]
rails_1 | [2016-02-27 05:38:57] INFO  WEBrick::HTTPServer#start: pid=10 port=3000
```
