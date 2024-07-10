#!/usr/bin/env bash

# FROM descartesresearch/teastore-base:latest
# MAINTAINER Chair of Software Engineering <se2-it@informatik.uni-wuerzburg.de>
export CATALINA_HOME=/usr/local/tomcat
export TOMCAT_HEAP_MEM_PERCENTAGE=50

cp teastores_war/*image.war "$CATALINA_HOME"/webapps/

java -jar "$CATALINA_HOME"/bin/dockermemoryconfigurator.jar "${TOMCAT_HEAP_MEM_PERCENTAGE}"
"$CATALINA_HOME"/bin/start.sh
"$CATALINA_HOME"/bin/catalina.sh run