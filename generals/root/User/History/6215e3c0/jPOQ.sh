#!/usr/bin/env bash

CATALINA_HOME=$( pwd )
TOMCATS_ARRAY=("tomcat-registry" "tomcat-webui" "tomcat-persistence" "tomcat-image" "tomcat-auth" "tomcat-recommender")
TOMCAT_HEAP_MEM_PERCENTAGE=50

reset

for index in ${TOMCATS_ARRAY[@]}; do

    echo "iniciando $index"; sleep 1.5

    export CATALINA_HOME="$CATALINA_HOME"

    rm -r $CATALINA_HOME/kieker
    mkdir -p $CATALINA_HOME/kieker
    mkdir -p $CATALINA_HOME/kieker/config
    mkdir -p $CATALINA_HOME/kieker/agent
    mkdir -p $CATALINA_HOME/kieker/logs

    cp $CATALINA_HOME/kieker.monitoring.properties $CATALINA_HOME/kieker/config/kieker.monitoring.properties
    cp $CATALINA_HOME/aop.xml $CATALINA_HOME/lib/aop.xml
    cp $CATALINA_HOME/kieker-1.15-SNAPSHOT-aspectj.jar $CATALINA_HOME/kieker/agent/agent.jar

    rm $CATALINA_HOME/lib/websocket-api.jar
    rm $CATALINA_HOME/lib/tomcat-websocket.jar

    cp $CATALINA_HOME/baseContext.xml $CATALINA_HOME/conf/context.xml
    cp $CATALINA_HOME/mysql-connector-java-5.1.44-bin.jar $CATALINA_HOME/lib/mysql-connector-java-5.1.44-bin.jar
    cp $CATALINA_HOME/dockermemoryconfigurator-1.4.2.jar $CATALINA_HOME/bin/dockermemoryconfigurator.jar

    rm -r $CATALINA_HOME/conf/server.xml
    cp $CATALINA_HOME/server.xml $CATALINA_HOME/conf/server.xml

    cp -r $CATALINA_HOME/ssl $CATALINA_HOME

    # Copy script to replace placeholders in context.xml with the environment variables
    cp $CATALINA_HOME/start.sh $CATALINA_HOME/bin/start.sh
    chmod +x $CATALINA_HOME/bin/start.sh

    # Import self-signed certificate for HTTPS teastore into keystore. NOTE: to adapt certificate hostnames, configure and run ssl/generate_cert.sh and rebuild the container!
    keytool -import -noprompt -trustcacerts -alias teastoressl -file $CATALINA_HOME/ssl/cert.pem -keystore "/usr/local/jdk-17.0.11/lib/security/cacerts" -storepass changeit

    sed -i "/JDK_JAVA_OPTIONS.*/d" $CATALINA_HOME/bin/catalina.sh

    # java -jar $CATALINA_HOME/$index/bin/dockermemoryconfigurator.jar ${TOMCAT_HEAP_MEM_PERCENTAGE};
    # bash $CATALINA_HOME/$index/bin/start.sh $CATALINA_HOME/$index
    # bash $CATALINA_HOME/$index/bin/catalina.sh run

done