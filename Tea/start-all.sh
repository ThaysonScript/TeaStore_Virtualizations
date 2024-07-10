#!/usr/bin/env bash

source ./start-registry.sh &
{
    source ./start-webui.sh &
    source ./start-persistence.sh &
    source ./start-auth.sh &
    source ./start-image.sh &
    source ./start-recommender.sh &
}