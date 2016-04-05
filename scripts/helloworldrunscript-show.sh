#!/bin/bash
# Helloworld runscript script
# This script is run on the obdi-worker

# Say hello
echo "Hello from $HOSTNAME"
echo

# Output the arguments
echo "-----------------"
echo "Program Arguments"
echo "-----------------"
echo "$@"

# Output the environment
echo "-----------"
echo "Environment"
echo "-----------"
env

exit 0
