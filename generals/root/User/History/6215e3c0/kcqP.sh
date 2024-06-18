#!/usr/bin/env bash

CATALINA_HOME=$( pwd )

reset; export $CATALINA_HOME/tomcat-registry; bash tomcat-registry/bin/catalina.sh run

export $CATALINA_HOME/tomcat-webui; bash tomcat-webui/bin/catalina.sh run
export $CATALINA_HOME/tomcat-persistence; bash tomcat-persistence/bin/catalina.sh run
export $CATALINA_HOME/tomcat-image; bash tomcat-image/bin/catalina.sh run
export $CATALINA_HOME/tomcat-auth; bash tomcat-auth/bin/catalina.sh run
export $CATALINA_HOME/tomcat-recommender; bash tomcat-recommender/bin/catalina.sh run