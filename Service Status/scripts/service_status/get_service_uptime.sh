#!/bin/bash

# Get the service name passed as the first argument
SERVICE_NAME="$1"

# Replace "%" with "@" if it exists in the service name
SERVICE_NAME=$(echo "$SERVICE_NAME" | sed 's/%/@/g')

# Check if the service is running using systemctl
if systemctl is-active --quiet "$SERVICE_NAME"; then
    # Get the uptime of the service in seconds
    UPTIME=$(systemctl show "$SERVICE_NAME" --property=ActiveEnterTimestamp | awk -F'=' '{print $2}')
    
    # Convert the timestamp to seconds since epoch
    UPTIME_SECONDS=$(date --date="$UPTIME" +%s)
    
    # Get the current time in seconds since epoch
    CURRENT_TIME=$(date +%s)
    
    # Calculate the difference (uptime in seconds)
    echo $((CURRENT_TIME - UPTIME_SECONDS))
else
    # If the service is not running, return 0
    echo 0
fi
