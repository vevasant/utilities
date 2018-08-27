#!/usr/bin/env bash
# This script is used to pause and resume a process after 5 seconds.
# This script helps in determining the behaviour of clients
# interacting with this process, when process does not respond to any of
# requests during pause period.

PROCESS_HOME=/path/to/process/dir
PROCESS_OWNER=username
process_id=`/bin/ps -fu $PROCESS_OWNER | grep $PROCESS_HOME/path/to/process/properties/file | awk '{print $2}'`
echo "Pausing process with ID - $process_id"
kill -STOP $process_id
sleep 5
echo "Resuming process with ID - $process_id"
kill -CONT $process_id


