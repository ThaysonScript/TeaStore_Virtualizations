#!/bin/bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")
TOMCAT_HEAP_MEM_PERCENTAGE=50

reset

for index in ${TOMCATS_ARRAY[@]}; do

    java -jar $CATALINA_HOME/$index/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
    bash $CATALINA_HOME/$index/bin/start.sh $CATALINA_HOME/$index
    bash $CATALINA_HOME/$index/bin/catalina.sh run

done