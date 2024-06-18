#!/bin/bash

TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")

reset
for index in ${ TOMCATS_ARRAY[@] }; do

echo $CATALINA_HOME/$index; echo $index/bin/catalina.sh run 

done