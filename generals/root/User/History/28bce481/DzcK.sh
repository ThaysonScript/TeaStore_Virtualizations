#!/bin/bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")
TOMCAT_HEAP_MEM_PERCENTAGE=50

reset

# export CATALINA_HOME="$CATALINA_HOME/tomcat-registry"
# export CATALINA_HOME="$CATALINA_HOME/tomcat-webui"
# export CATALINA_HOME="$CATALINA_HOME/tomcat-persistence"
# export CATALINA_HOME="$CATALINA_HOME/tomcat-image"
# export CATALINA_HOME="$CATALINA_HOME/tomcat-auth"
# export CATALINA_HOME="$CATALINA_HOME/tomcat-recommender"

for index in ${TOMCATS_ARRAY[@]}; do

    export CATALINA_HOME="$CATALINA_HOME/$index"
    echo "aqui o echo $CATALINA_HOME"

    java -jar $CATALINA_HOME/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
    bash $CATALINA_HOME/bin/start.sh $CATALINA_HOME/$index
    bash $CATALINA_HOME/bin/catalina.sh run

    sleep 2

    CATALINA_HOME=""

done