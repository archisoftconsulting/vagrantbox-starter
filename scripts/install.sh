# Install dependencies and software
#sudo apt-get install zip unzip
#sudo add-apt-repository ppa:openjdk-r/ppa --yes
#sudo apt-get update
#sudo apt-get install --yes openjdk-8-jdk
dpkg -s zip 2>/dev/null >/dev/null || sudo apt-get -y install zip unzip
dpkg -s openjdk-8-jdk 2>/dev/null >/dev/null || (sudo add-apt-repository ppa:openjdk-r/ppa --yes && sudo apt-get update && sudo apt-get install --yes openjdk-8-jdk)

# set Home Path
B2B_HOME=/home/vagrant/b2b

# Create Directory and assign permission
if [ ! -d "$B2B_HOME" ]; then
 
	sudo mkdir $B2B_HOME && sudo chown -R vagrant:vagrant $B2B_HOME
	sudo mkdir $B2B_HOME/tools

	# Download
	# Money Transfer sample
	sudo wget https://github.com/cer/event-sourcing-examples/archive/master.zip && unzip master.zip -d $B2B_HOME  && rm -rf master.zip
	# To do list sample
	#sudo wget https://github.com/eventuate-examples/eventuate-examples-java-spring-todo-list/archive/master.zip && unzip master.zip -d $B2B_HOME  && rm -rf master.zip
	# Customers and order sample
	#sudo wget https://github.com/eventuate-examples/eventuate-examples-java-customers-and-orders/archive/master.zip && unzip master.zip -d $B2B_HOME  && rm -rf master.zip
	# Restaurent Management sample
	#sudo wget https://github.com/eventuate-examples/eventuate-examples-restaurant-management/archive/master.zip && unzip master.zip -d $B2B_HOME  && rm -rf master.zip
	# Kanban board sampple
	#sudo wget https://github.com/eventuate-examples/es-kanban-board/archive/master.zip && unzip master.zip -d $B2B_HOME && rm -rf master.zip
	# Download IntelliJ
	#sudo wget https://download.jetbrains.com/idea/ideaIC-2017.1.1.tar.gz && tar -xzvf ideaIC-2017.1.1.tar.gz -C tools && rm -rf ideaIC-2017.1.1.tar.gz
	# Downlload Spring Tool Suite
	#sudo wget http://download.springsource.com/release/STS/3.8.4.RELEASE/dist/e4.6/spring-tool-suite-3.8.4.RELEASE-e4.6.3-linux-gtk-x86_64.tar.gz && tar -xzvf spring-tool-suite-3.8.4.RELEASE-e4.6.3-linux-gtk-x86_64.tar.gz -C tools && rm -rf spring-tool-suite-3.8.4.RELEASE-e4.6.3-linux-gtk-x86_64.tar.gz

	# Compile sample projects
	cd $B2B_HOME/event-sourcing-examples-master/java-spring && ./gradlew assemble -P eventuateDriver=local
	#cd $B2B_HOME/eventuate-examples-java-spring-todo-list-master && ./gradlew assemble -P eventuateDriver=local
	#cd $B2B_HOME/eventuate-examples-java-customers-and-orders && ./gradlew assemble -P eventuateDriver=local
	#cd $B2B_HOME/eventuate-examples-restaurant-management && ./gradlew assemble -P eventuateDriver=local
	#cd $B2B_HOME/es-kanban-board-master/java-server && ./gradlew assemble -P eventuateDriver=local

	# Create command to start stop status
	cd $B2B_HOME
	sudo echo "export DOCKER_HOST_IP;sudo docker-compose -f docker-compose-eventuate-local.yml up -d" >>  startup.sh && chmod +x startup.sh
	sudo echo "sudo docker-compose -f docker-compose-eventuate-local.yml ps" >> status.sh && chmod +x status.sh
	sudo echo "sudo docker-compose -f docker-compose-eventuate-local.yml down" >> shutdown.sh && chmod +x shutdown.sh
	sudo echo "sudo docker-compose -f docker-compose-eventuate-local.yml logs -f" >> logs.sh && chmod +x logs.sh
	sudo cp startup.sh status.sh shutdown.sh logs.sh $B2B_HOME/event-sourcing-examples-master/java-spring
	#sudo cp startup.sh status.sh shutdown.sh $B2B_HOME/eventuate-examples-java-spring-todo-list-master
	#sudo cp startup.sh status.sh shutdown.sh $B2B_HOME/eventuate-examples-java-customers-and-orders
	#sudo cp startup.sh status.sh shutdown.sh $B2B_HOME/eventuate-examples-restaurant-management
	#sudo cp startup.sh status.sh shutdown.sh $B2B_HOME/es-kanban-board-master/java-server 
	sudo rm -rf startup.sh status.sh shutdown.sh logs.sh

fi

if [ ! -d "$B2B_HOME/tools/mongodb/data" ]; then
	sudo docker run --name mongodb -d -p 27017:27017 -v $B2B_HOME/tools/mongodb/data:/data/db mongo
	cd $B2B_HOME/tools/mongodb && sudo wget https://download.robomongo.org/1.0.0/linux/robomongo-1.0.0-linux-x86_64-89f24ea.tar.gz
	unzip robomongo-1.0.0-linux-x86_64-89f24ea.tar.gz -d $B2B_HOME/tools/mongodb  && rm -rf robomongo-1.0.0-linux-x86_64-89f24ea.tar.gz
fi 
