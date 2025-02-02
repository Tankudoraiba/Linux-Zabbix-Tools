#!/bin/bash

OUTPUT_FILE="/etc/zabbix/zabbix_agent2.d/scripts/service_status/tmp/service_statuses.txt"
OUTPUT_FILE2="/etc/zabbix/zabbix_agent2.d/scripts/service_status/tmp/port_statuses.txt"

echo "" > $OUTPUT_FILE
echo "" > $OUTPUT_FILE2

systemctl list-units --type=service --state=running --all --no-pager --no-legend | awk '{print $1}' | while read SERVICE; do

    PID=$(systemctl show "$SERVICE" --property MainPID | cut -d'=' -f2)
    PORT=$(sudo lsof -i -P -n | grep LISTEN | grep "$PID" | awk '{print $9}' | cut -d':' -f2)
    SERVICE=$(echo "$SERVICE" | sed 's/@/%/g')    
    
    echo "$SERVICE" >> $OUTPUT_FILE
    echo "$PORT" >> $OUTPUT_FILE
done

echo "Service statuses saved to $OUTPUT_FILE"

