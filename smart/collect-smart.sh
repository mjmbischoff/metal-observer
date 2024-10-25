#!/bin/bash

SMARTCTL_COMMAND="smartctl"
SMARTCTL_SCAN_PARAMS=(--scan)
SMARTCTL_PROCESS_COMMAND=(cut -f1 -d ' ')
SMARTCTL_COLLECTION_PARAMS=(-j -x)

POST_COMMAND="curl"
POST_URL="http://localhost:44002"
POST_PARAMS=(-X POST -H 'Content-Type: application/json' -d @-)

type $SMARTCTL_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${SMARTCTL_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

type $POST_COMMAND >/dev/null 2>&1 || { 
    echo >&2 "I require ${POST_COMMAND} but it's not installed.  Aborting."; 
    exit 1; 
}

"${SMARTCTL_COMMAND}" "${SMARTCTL_SCAN_PARAMS[@]}" | "${SMARTCTL_PROCESS_COMMAND[@]}" | xargs -n 1 "${SMARTCTL_COMMAND}" "${SMARTCTL_COLLECTION_PARAMS[@]}" | "${POST_COMMAND}" "${POST_URL}" "${POST_PARAMS[@]}"