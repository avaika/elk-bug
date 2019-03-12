#!/bin/bash

echo '{"timestamp": '$(date +%s)', "field": '$RANDOM', "seqnum": 100, "text": "Some text"}' >> input.json
sleep 30
for i in {1..10}; do
  echo '{"timestamp": '$(date +%s)', "field": '$RANDOM', "seqnum": 10000000'$(date +%s)', "text": "Some text"}' >> input.json
  sleep 1
done
