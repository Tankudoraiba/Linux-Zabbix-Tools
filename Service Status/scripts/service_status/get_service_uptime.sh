#!/bin/bash

SERVICE_NAME="$1"

SERVICE_NAME=$(echo "$SERVICE_NAME" | sed 's/%/@/g')

if systemctl is-active --quiet "$SERVICE_NAME"; then
    
    UPTIME=$(systemctl show "$SERVICE_NAME" --property=ActiveEnterTimestamp | awk -F'=' '{print $2}')

    UPTIME_SECONDS=$(date --date="$UPTIME" +%s)
    
    CURRENT_TIME=$(date +%s)

    echo $((CURRENT_TIME - UPTIME_SECONDS))
else
    echo 0
fi
