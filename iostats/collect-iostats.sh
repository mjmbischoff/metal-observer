#!/bin/bash

POST_COMMAND="curl"
POST_URL="http://localhost:44003"
POST_PARAMS=(-X POST -H 'Content-Type: application/json' -d @-)

IOSTAT_COMMAND="iostat"

type $SMARTCTL_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${IOSTAT_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

type $POST_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${POST_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

S_TIME_FORMAT=ISO "${IOSTAT_COMMAND}" -o JSON -d -x -t | "${POST_COMMAND}" "${POST_URL}" "${POST_PARAMS[@]}"