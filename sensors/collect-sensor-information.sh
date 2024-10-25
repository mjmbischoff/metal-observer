#!/bin/bash

SENSORS_COMMAND=sensors
SENSORS_PARAMS=(-j)

POST_COMMAND="curl"
POST_URL="http://localhost:44001"
POST_PARAMS=(-X POST -H 'Content-Type: application/json' -d @-)

type $SENSORS_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${SENSORS_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

type $POST_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${POST_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

${SENSORS_COMMAND} ${SENSORS_PARAMS[@]} | "${POST_COMMAND}" "${POST_URL}" "${POST_PARAMS[@]}"