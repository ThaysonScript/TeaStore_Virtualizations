#!/bin/bash

java -jar $CATALINA_HOME/$index/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
bash $CATALINA_HOME/$index/bin/start.sh $CATALINA_HOME/$index
bash $CATALINA_HOME/$index/bin/catalina.sh run