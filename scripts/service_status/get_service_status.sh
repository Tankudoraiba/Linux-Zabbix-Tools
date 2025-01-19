#!/bin/bash

# Get the service name passed as the first argument
SERVICE_NAME="$1"

# Replace "%" with "@" if it exists in the service name
SERVICE_NAME=$(echo "$SERVICE_NAME" | sed 's/%/@/g')

# Check if the service is running using systemctl or ps
if systemctl is-active --quiet "$SERVICE_NAME"; then
    # If the service is running, return 1
    echo 1
else
    # If the service is not running, return 0
    echo 0
fi

