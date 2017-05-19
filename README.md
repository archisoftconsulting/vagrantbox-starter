# VagrantBox-starter
This is a starter on setting up a local VDE(Virtual Development Environment) with vagrantbox image that consist of:
1. Ubuntu OS
2. JDK 8
3. Docker + Docker compose
4. Microservice demo app

Ubuntu login and password = vagrant/vagrant

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

## Install JDK, Docker and Microservice Demo app
Download https://github.com/archisoftconsulting/vagrantbox-starter/archive/master.zip
and extract it.

Copy Vagrantfile and scripts folder and paste overwrite your D:\vagrantbox
The installation steps all inside above 2 files/folder. 

(Edit the Vagranfile and install.sh you will see all the command that perform installation)

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
Run the following commmand ./startup.sh

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
Take note first time statup will take sometime to download the dependencies and compilation.

## Check status demo app
Run the following commmand ./status.sh
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
Run the following commmand ./logs.sh
```
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./logs.sh
```
## Browse the app
Open browser enter http://localhost:8080

## shutdown the app
Run the following commmand ./shutdown.sh
```
vagrant@vagrant:~/b2b/event-sourcing-examples-master/java-spring$ ./shutdown.sh
```

## How to stop and save state of the vagrantbox
```
D:\vagrantbox> vagrant suspend
```
## How to start the vagrantbox and restore the state
```
D:\vagrantbox> vagrant up
```
## How to "clean up" the vagrantbox and start the base image that you initially downloaded
Note that DO NOT simply run this. It will uninstall all the software and when you start up the image, it will back to the default ubuntu image without any software inside.
```
D:\vagrantbox> vagrant destroy
D:\vagrantbox> vagrant up
```
## How to fine tune the vagrantbox for best performance
Allocate at least 50-60% of your total RAM and 50-60% of your total CPU core to the vbox. You can change the RAM at vagrantfile or manually adjust the virtualBox setting.

## How to install new software and ensure it can transfer to other vagrantbox
Several ways to do this:

1. Edit vagrantfile or install.sh file, add the install command and comment out the rest command that already run. Then enter
```
D:\vagrantbox> vagrant provision
```
2. vagrant package - This command will export the current vbox into a file package.box, and you can transfer the package.box file to others. Then edit vagrantfile to include the package.box when startup vagrant. (Try to avoid this consume disk space, most cases you can transfer vagrantfile and gitclone for the code you working on)

Below vagrantfile to include the package.box
```
config.vm.box_url = "file:///G:/vagrantbox_ubuntudesktop_package/package.box"
```
