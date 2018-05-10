#!/usr/bin/env bash

echo "Loading keys..."
count=0
num_keys=0
for file in ~/.ssh/*.pub
do
  base=${file/.pub/}
  echo "$base"
  ssh-add "$base"
  if [ $? -eq 0 ]; then
    echo "Success: yes"
    let count++
  else
    echo "Success: no"
  fi
  let num_keys++
done

echo "Successfully loaded $count of $num_keys keys"

