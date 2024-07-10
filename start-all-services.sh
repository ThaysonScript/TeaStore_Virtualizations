#!/usr/bin/env bash

GET_DEPENDENCIES() {
    # shellcheck disable=SC1091
    source ./Tea/tools.descartes.teastore.dockerbase/tea_base.sh

    cp -r /usr/local/tomcat /root/tomcat-cp
}

CONFIG_ALL_SERVICES() {
    echo "imp"
}

START_ALL_SERVICES() {
    echo "imp"
}

MAIN() {
    GET_DEPENDENCIES
    CONFIG_ALL_SERVICES
    START_ALL_SERVICES
}

MAIN