#!/bin/bash

# File to store service statuses
OUTPUT_FILE="/etc/zabbix/zabbix_agent2.d/scripts/service_status/service_statuses.txt"

echo "" > $OUTPUT_FILE

# Get the list of all services
systemctl list-units --type=service --state=running --all --no-pager --no-legend | awk '{print $1}' | while read SERVICE; do

    # Replace "@" with "%" if it exists in the service name
    SERVICE=$(echo "$SERVICE" | sed 's/@/%/g')

    # Write the service and its status to the file
    echo "$SERVICE" >> $OUTPUT_FILE
done

echo "Service statuses saved to $OUTPUT_FILE"

