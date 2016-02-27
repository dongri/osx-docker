### Build
```
$ docker build -t nginx .
```

### Run
```
$ docker run -d -p 80:80 nginx
```

### boot2docker(vangrant)
```
$ curl http://localhost:80
```

### Max OS X
```
$ VBoxManage controlvm "boot2docker-vm" natpf1 "nginx,tcp,127.0.0.1,8080,,80"
$ curl http://localhost:8080
````

ポートフォワーディングは
OSX 8080 ---> VirtualBox 80 ---> nginx 80
