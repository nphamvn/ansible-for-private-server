#!/bin/bash
set -e

# add localhost to known_hosts to avoid prompt
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

# test ssh connection localhost:30001 with username/password pi/zzzz
sshpass -p "zzzz" ssh -o StrictHostKeyChecking=no -p 30001 pi@localhost "echo 'SSH connection to localhost:30001 successful'"
