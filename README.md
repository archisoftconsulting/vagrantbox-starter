# vagrantbox-starter
This is a starter guide that shows how to setup a basic local virtual development environment.

## Install VirtualBox
Goto https://www.virtualbox.org/wiki/Downloads and click Windows hosts to download the exe file(installer) and run the exe to install it.

## Install Vagrant
Goto https://www.vagrantup.com/downloads.html and click on Windows Universal(32 and 64bit) to download the msi file(installer) and run the msi to install it.

Open Windows command prompt and create a working folder, for example D:\vagrantbox

```
D:\> mkdir vagrantbox
D:\> cd vagrantbox
D:\vagrantbox> vagrant plugin install vagrant-docker-compose
D:\vagrantbox> vagrant init box-cutter/ubuntu1404-desktop
```

## Download Vagrantfile and scripts folder from this github and paste overwrite into D:\vagrantbox folder
```
D:\vagrantbox> dir/w
```
You should see Vagrantfile and scripts folder. Inside scripts folder should have install.sh file.

## Start up the virtualbox
```
D:\vagrantbox> vagrant up --provider virtualbox
```

## Start up the demo app
Inside ubuntu, press CTRL+ALT+T to open up terminal.

```
vagrant@vagrant:~$ cd b2b/event-sourcing-examples-master/java-spring/
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./startup.sh
WARNING: The DOCKER_HOST_IP variable is not set. Defaulting to a blank string.
Creating javaspring_mongodb_1
Creating javaspring_mysql_1
Creating javaspring_zookeeper_1
Creating javaspring_kafka_1
Creating javaspring_customersservice_1
Creating javaspring_accountsservice_1
Creating javaspring_transactionsservice_1
Creating javaspring_customersviewservice_1
Creating javaspring_accountsviewservice_1
Creating javaspring_cdcservice_1
Creating javaspring_apigateway_1
```

## Check status demo app
```
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./status.sh
WARNING: The DOCKER_HOST_IP variable is not set. Defaulting to a blank string.
              Name                             Command               State                                   Ports                                  
---------------------------------------------------------------------------------------------------------------------------------------------------
javaspring_accountsservice_1        /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8085->8080/tcp                                                 
javaspring_accountsviewservice_1    /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8081->8080/tcp                                                 
javaspring_apigateway_1             /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8080->8080/tcp                                                 
javaspring_cdcservice_1             /bin/sh -c java -jar *.jar       Up      0.0.0.0:8099->8080/tcp                                                 
javaspring_customersservice_1       /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8083->8080/tcp                                                 
javaspring_customersviewservice_1   /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8084->8080/tcp                                                 
javaspring_kafka_1                  /bin/sh -c ./run-kafka.sh        Up      0.0.0.0:9092->9092/tcp                                                 
javaspring_mongodb_1                /entrypoint.sh mongod --sm ...   Up      0.0.0.0:27017->27017/tcp                                               
javaspring_mysql_1                  docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp                                                 
javaspring_transactionsservice_1    /bin/sh -c java ${JAVA_OPT ...   Up      0.0.0.0:8082->8080/tcp                                                 
javaspring_zookeeper_1              /usr/local/zookeeper-3.4.8 ...   Up      0.0.0.0:2181->2181/tcp, 0.0.0.0:2888->2888/tcp, 0.0.0.0:3888->3888/tcp 
```

## check logs of the app
```
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./logs.sh
```

## shutdown the app
```
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./shutdown.sh
```
