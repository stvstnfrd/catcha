#!/bin/bash

GRAILS_VERSION=2.2.1
GVM_INSTALL_SCRIPT=/tmp/install-gvm.sh
GVM_INIT_SCRIPT=${HOME}/.gvm/bin/gvm-init.sh
JAVA_INSTALL_PATH=/usr/lib/jvm/default-java
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASS=edx
MYSQL_USER_NAME=catch
MYSQL_USER_PASS=edx
MYSQL_TABLE_NAME=catch
MYSQL_SERVER_HOST=localhost
SUDO=sudo

${SUDO} apt-get update

# configure mysql
${SUDO} debconf-set-selections \
    <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASS}"
${SUDO} debconf-set-selections \
    <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASS}"
${SUDO} apt-get install mysql-server --yes
mysql -u "${MYSQL_ROOT_USER}" -p"${MYSQL_ROOT_PASS}" -e \
    "create database catch default charset utf8;"
mysql -u "${MYSQL_ROOT_USER}" -p"${MYSQL_ROOT_PASS}" -e \
    "grant all on \'${MYSQL_TABLE_NAME}\'.* to \'${MYSQL_USER_NAME}\'@\'${MYSQL_SERVER_HOST}\' identified by \'${MYSQL_USER_PASS}\';"

# should we be installing 1.7?
${SUDO} apt-get install default-jre --yes
echo "export JAVA_HOME=${JAVA_INSTALL_PATH}" >> "${HOME}/.bashrc"
export JAVA_HOME=${JAVA_INSTALL_PATH}

${SUDO} apt-get install unzip --yes
${SUDO} apt-get install curl --yes
curl --output "${GVM_INSTALL_SCRIPT}" get.gvmtool.net
bash "${GVM_INSTALL_SCRIPT}"
${SUDO} rm "${GVM_INSTALL_SCRIPT}"
. "${GVM_INIT_SCRIPT}"

# say yes to set as default
gvm install grails "${GRAILS_VERSION}"

git clone https://github.com/annotationsatharvard/catcha.git /var/catcha
cd /var/catcha
cd Catch
grails run-app

