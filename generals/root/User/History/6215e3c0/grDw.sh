#!/usr/bin/env bash

reset; export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-registry; bash tomcat-registry/bin/catalina.sh run

export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-webui; bash tomcat-webui/bin/catalina.sh run
export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-persistence; bash tomcat-persistence/bin/catalina.sh run
export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-image; bash tomcat-image/bin/catalina.sh run
export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-auth; bash tomcat-auth/bin/catalina.sh run
export CATALINA_HOME=/home/thayson/pasta-tomcat/tomcat-recommender; bash tomcat-recommender/bin/catalina.sh run