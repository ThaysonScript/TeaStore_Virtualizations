#!/usr/bin/env bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")

reset
for index in ${TOMCATS_ARRAY[@]}; do

    cp $CATALINA_HOME/baseContext.xml $CATALINA_HOME/$index/conf/context.xml
    cp $CATALINA_HOME/mysql-connector-java-5.1.44-bin.jar $CATALINA_HOME/$index/lib/mysql-connector-java-5.1.44-bin.jar
    cp $CATALINA_HOME/dockermemoryconfigurator-1.4.2.jar $CATALINA_HOME/$index/bin/dockermemoryconfigurator.jar

    export $CATALINA_HOME/$index; bash $index/bin/catalina.sh run

done