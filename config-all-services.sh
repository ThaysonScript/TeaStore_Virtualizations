#!/usr/bin/env bash

[[ "$(pwd)" != "/root/teastore-no-containers" ]] && {
    echo -e "\nverifique o pwd, execute diretamente no diretorio ./teastore-no-containers: pwd = $(pwd)"; exit 1
}

PID_SERVICES=()
PWD_PATH="$(pwd)/Tea"


GET_DEPENDENCIES() {
    local pwd_tea_base; pwd_tea_base=$(pwd)

    # shellcheck disable=SC1091
    bash "$pwd_tea_base/Tea/tools.descartes.teastore.dockerbase/tea_base.sh"
}


CONFIG_ALL_SERVICES() {
    echo 'export JAVA_HOME="/usr/local/openjdk-11"' >> /root/.bashrc
    echo "export PATH=\$PATH:$JAVA_HOME/bin" >> /root/.bashrc

    # shellcheck disable=SC1091
    source /root/.bashrc

    # -------------------------- REGISTRY SERVICE
    reset; echo -e "\nconfigure and start service: registry\n"
    bash "$PWD_PATH/registry.sh"
    bash "$PWD_PATH/start-registry.sh"
    PID_SERVICES+=($!)
    GET_DEPENDENCIES

    # -------------------------- WEBUI SERVICE
    echo -e "\nconfigure and start service: webui\n"
    bash "$PWD_PATH/webui.sh"
    bash "$PWD_PATH/start-webui.sh"
    PID_SERVICES+=($!)
    GET_DEPENDENCIES

    # -------------------------- PERSISTENCE SERVICE
    echo -e "\nconfigure and start service: persistence\n"
    bash "$PWD_PATH/persistence.sh"
    bash "$PWD_PATH/start-persistence.sh"
    PID_SERVICES+=($!)
    GET_DEPENDENCIES

    # -------------------------- AUTH SERVICE
    echo -e "\nconfigure and start service: auth\n"
    bash "$PWD_PATH/auth.sh"
    bash "$PWD_PATH/start-auth.sh"
    PID_SERVICES+=($!)
    GET_DEPENDENCIES

    # -------------------------- IMAGE SERVICE
    echo -e "\nconfigure and start service: image\n"
    bash "$PWD_PATH/image.sh"
    bash "$PWD_PATH/start-image.sh"
    PID_SERVICES+=($!)
    GET_DEPENDENCIES

    # -------------------------- RECOMMENDER SERVICE
    echo -e "\nconfigure and start service: recommender\n"
    bash "$PWD_PATH/recommender.sh"
    bash "$PWD_PATH/start-recommender.sh"
    PID_SERVICES+=($!)
}


MAIN() {
    GET_DEPENDENCIES
    CONFIG_ALL_SERVICES

    echo -e "\nMostrando pids em segundo plano dos serviços executados\n"
    local i=1
    export PID_SERVICES && {
        for pid in "${PID_SERVICES[@]}"; do
            echo "serviço $i: $pid"
            ((i+=1))
        done
    }
    echo -e "\nArray pids dos serviços, use kill -9 (pid) em cada pid para matar serviço: $PID_SERVICES\n"
}

MAIN