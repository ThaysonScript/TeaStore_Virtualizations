#!/bin/bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")
TOMCAT_HEAP_MEM_PERCENTAGE=50

reset

for index in ${TOMCATS_ARRAY[@]}; do

    export CATALINA_HOME="$CATALINA_HOME/$index"

    java -jar $CATALINA_HOME/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
    bash $CATALINA_HOME/bin/start.sh $CATALINA_HOME/$index
    bash $CATALINA_HOME/bin/catalina.sh run

    sleep 2
    
done