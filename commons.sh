#!/usr/bin/env bash

# tomcat-registry
# tomcat-webui
# tomcat-auth
# tomcat-persistence
# tomcat-recommender
# tomcat-image
# tomcat-db
TOMCAT_INSTANCE="tomcat-$1"

TARGET_WAR="TeaStore/services/tools.descartes.teastore.auth/target/*.war"
TOMCAT_WEBAPPS="tomcat/webapps"

TOMCAT_START="/usr/local/tomcat/bin/start.sh"
CATALINA_RUN="/usr/local/tomcat/bin/catalina.sh run"

# /usr/local/tomcat/bin/dockermemoryconfigurator.jar
PATH_DOCKER_MEM_CONFIG="path_to_dockermemoryconfigurator.jar"

CP_TARGET_WAR() {
    local war=$1
    local webapps=$2
    # shellcheck disable=SC2086
    cp $war $webapps
}

CP_DOCKER_MEM_CONFIG() {
    local tomcat_heap=$1
    local docker_mem_config="$PATH_DOCKER_MEM_CONFIG"

    cp target/jars/dockermemoryconfigurator* /usr/local/tomcat/bin/dockermemoryconfigurator.jar

    java -jar $docker_mem_config "$tomcat_heap"
}

START_TOMCAT_CATALINA() {
    bash "$TOMCAT_START"; bash "$CATALINA_RUN"
}

JDK_JAVA_OPTIONS() {
    sed -i "/JDK_JAVA_OPTIONS.*/d" /usr/local/tomcat/bin/catalina.sh
}

CP_SLF4J() {
    cp slf4j-simple-1.7.21.jar /usr/local/slf4j-simple-1.7.21.jar
}

CP_KIEKER() {
    cp kieker-1.15-SNAPSHOT-aspectj.jar /kieker/agent/agent.jar
}

CP_AOP() {
    cp aop.xml /usr/local/tomcat/lib/aop.xml
}

CP_KIEKER_PROPERTIES() {
    cp kieker.monitoring.properties /kieker/config/kieker.monitoring.properties
}

KEYTOOL() {
    bash keytool -import -noprompt -trustcacerts -alias teastoressl -file /usr/local/tomcat/ssl/cert.pem -keystore "/usr/local/openjdk-11/lib/security/cacerts" -storepass changeit
}

CP_START_SH() {
    cp start.sh /usr/local/tomcat/bin/start.sh
    chmod +x /usr/local/tomcat/bin/start.sh
}

CP_SSL() {
    cp ssl/ /usr/local/tomcat/ssl
}

CP_SERVER_XML() {
    rm -r /usr/local/tomcat/conf/server.xml
    cp server.xml /usr/local/tomcat/conf/
}

CP_MYSQL() {
    cp mysql-connector-java-5.1.44-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.44-bin.jar
}

CP_CONTEXT_XML() {
    rm -r /usr/local/tomcat/conf/context.xml
    cp baseContext.xml /usr/local/tomcat/conf/context.xml
}

RM_WEBSOCKETS() {
    rm -r /usr/local/tomcat/lib/tomcat-websocket.jar
    rm -r /usr/local/tomcat/lib/websocket-api.jar
}

# MAIN CODE CALLS
MAIN() {
    CP_TARGET_WAR "$TARGET_WAR" "$TOMCAT_WEBAPPS"
    CP_DOCKER_MEM_CONFIG "${TOMCAT_HEAP_MEM_PERCENTAGE}"
    START_TOMCAT_CATALINA
}
MAIN