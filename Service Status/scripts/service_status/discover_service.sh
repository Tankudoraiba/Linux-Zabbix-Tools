#!/bin/bash

OUTPUT_FILE="/etc/zabbix/zabbix_agent2.d/scripts/service_status/service_statuses.txt"

echo "" > $OUTPUT_FILE

systemctl list-units --type=service --state=running --all --no-pager --no-legend | awk '{print $1}' | while read SERVICE; do

    SERVICE=$(echo "$SERVICE" | sed 's/@/%/g')

    echo "$SERVICE" >> $OUTPUT_FILE
done

echo "Service statuses saved to $OUTPUT_FILE"

