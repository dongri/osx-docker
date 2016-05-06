# Docker on OSX

Docker example for mac osx

# Install Docker for Mac

https://beta.docker.com/docs/

# Docker

```
$ cd docker
$ docker-compose build
$ docker-compose start
```

# MySQL

```
docker@docker:~$ docker ps
docker@docker:~$ docker exec -it e3a69abfa3a3 /bin/bash
root@e3a69abfa3a3:/# mysql -u root

mysql>
```

# PostgreSQL

```
docker@docker:~$ docker ps
docker@docker:~$ docker exec -it dc5114934128 /bin/bash
root@dc5114934128:/# su - postgres
No directory, logging in with HOME=/
$ psql
psql (9.5.1)
Type "help" for help.

postgres=#
```

# Apps

```
$ cd apps/rails
$ docker-compose up
rails_1 | [2016-02-27 05:38:57] INFO  WEBrick 1.3.1
rails_1 | [2016-02-27 05:38:57] INFO  ruby 2.2.4 (2015-12-16) [x86_64-linux]
rails_1 | [2016-02-27 05:38:57] INFO  WEBrick::HTTPServer#start: pid=10 port=3000
```
