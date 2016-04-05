#!/bin/bash
# Helloworld runscript script
# This script is run on the obdi-worker

# Say hello
echo "Hello from $HOSTNAME"
echo

# Output the arguments
echo "Program Arguments"
echo "-----------------"
echo "$@"
echo

# Output the environment
echo "Environment"
echo "-----------"
env

exit 0
