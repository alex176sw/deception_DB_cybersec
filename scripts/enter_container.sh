#!/bin/bash

printf "Enter the user you want to enter the container as: "
read user

docker exec -it --user $user deception-db bash -l 