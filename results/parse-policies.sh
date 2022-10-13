#!/bin/bash

parse_data()
{
  # Parse Namespace
  ns=()

  for Namespace in $(kubectl get polr -A | awk 'NR>1{print $1}')
  do
    ns+=($Namespace)
  done

  # Parse Name
  polr_n=()
  for Name in $(kubectl get polr -A | awk 'NR>1{print $2}')
  do
    polr_n+=($Name)
  done

  d=`date +%m-%d-%Y`

  # Put Everything into seperate files
  for ((i = 0; i < ${#ns[@]}; i++)); do
    # kubectl describe -n ${ns[$i]} polr ${polr_n[$i]} | grep "Result: \+fail" -B10 >> "results/${polr_n[$i]}-result.txt"
    # kubectl get polr -n ${ns[$i]} ${polr_n[$i]} -o json | jq '[.results[] | select(.result == "fail") | {policy, resources}] | sort_by(.policy)' > "results/${polr_n[$i]}-result.txt"
    kubectl get polr -n ${ns[$i]} ${polr_n[$i]} -o json | jq '[.results[] | select(.result == "fail") | {policy, resources}] | sort_by(.policy) | select(length > 0)' >> "results/logs-$d.json"
  done

}

parse_data
