SHELL=/bin/bash
GRAILS_VERSION=2.2.1
MYSQL_ADMIN_USER=root
MYSQL_QUERY_USER=catch
MYSQL_QUERY_PASS=
MYSQL_DB_NAME=catch
MYSQL_HOST=localhost

all:
	@echo 'ok'
	grails run-app

.PHONY: install system java gvm grails mysql

install:
	make grails

grails: system mysql gvm
	# After downloading the source code check `catcha/Catch/application.properties` to find the required Grails version.
	# gvm install grails 2.2.1
	gvm install grails "${GRAILS_VERSION}"

system:
	sudo apt-get update
	sudo apt-get install unzip --yes
	sudo apt-get install curl --yes
	sudo apt-get install git --yes

mysql:
	sudo apt-get install mysql-server --yes
	# create database
	# mysql -u root -p -e 'create database catch default charset utf8;'
	# create database user
	mysql -u root -p -e 'grant all on catch.* to "catch"@"localhost" identified by "";'

java:
	# should we be installing 1.7?
	sudo apt-get install default-jre --yes
	echo 'export JAVA_HOME=/usr/lib/jvm/default-java/bin/java' >> "${HOME}/.bashrc"

gvm: java
	# this file should be under source control
	bash ./install-gvm.sh
	#bash "${HOME}/.gvm/bin/gvm-init.sh"

