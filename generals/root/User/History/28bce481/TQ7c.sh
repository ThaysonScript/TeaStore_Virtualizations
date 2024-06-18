#!/bin/bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")
TOMCAT_HEAP_MEM_PERCENTAGE=50

reset

# for index in ${TOMCATS_ARRAY[@]}; do

#     cd "$CATALINA_HOME/$index/bin"

#     java -jar dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
#     bash start.sh $CATALINA_HOME/$index
#     bash catalina.sh run

#     cd -

# done

# java -jar $CATALINA_HOME/tomcat-registry/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};

# cd "$CATALINA_HOME/tomcat-registry/bin"
bash "/home/thayson/pasta-tomcat/tomcat-registry/bin/start.sh" "$CATALINA_HOME/tomcat-registry"

# bash $CATALINA_HOME/tomcat-registry/bin/catalina.sh run