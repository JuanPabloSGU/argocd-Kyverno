#!/bin/bash
d=`date +%m-%d-%Y`
echo $(kubectl get polr -A -o json | jq '[.items[].results[] | select(.result == "fail") | {policy, resources}] | group_by(.policy)') > results/logs-$d.json
