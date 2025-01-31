#!/bin/bash

SERVICE_NAME="$1"

SERVICE_NAME=$(echo "$SERVICE_NAME" | sed 's/%/@/g')

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo 1
else
    echo 0
fi

