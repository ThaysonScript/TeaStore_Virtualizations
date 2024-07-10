#!/usr/bin/env bash

# FROM descartesresearch/teastore-base:latest
export CATALINA_HOME=/usr/local/tomcat
export TOMCAT_HEAP_MEM_PERCENTAGE=50

cp teastores_war/*webui.war "$CATALINA_HOME"/webapps/
mkdir -p "$CATALINA_HOME"/webapps/ROOT

java -jar "$CATALINA_HOME"/bin/dockermemoryconfigurator.jar "${TOMCAT_HEAP_MEM_PERCENTAGE}"
"$CATALINA_HOME"/bin/start.sh
echo '<% response.sendRedirect("/tools.descartes.teastore.webui/"); %>' > "$CATALINA_HOME"/webapps/ROOT/index.jsp
"$CATALINA_HOME"/bin/catalina.sh run