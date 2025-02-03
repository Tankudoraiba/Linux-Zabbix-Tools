#!/bin/bash

OUTPUT_FILE="/etc/zabbix/zabbix_agent2.d/scripts/service_status/tmp/port_statuses.txt"

echo "" > $OUTPUT_FILE

systemctl list-units --type=service --state=running --all --no-pager --no-legend | awk '{print $1}' | while read SERVICE; do

    # Attempt to get MainPID using systemctl
    PID=$(systemctl show "$SERVICE" --property MainPID | cut -d'=' -f2)
    
    SERVICE2=$(echo "$SERVICE" | cut -d'.' -f1)
    
    # If MainPID is empty or unavailable, try other methods
    if [ -z "$PID" ] || [ "$PID" -eq 0 ]; then
        # Use pgrep (finds the main process based on the service name)
        PID=$(pgrep -o -f "$SERVICE2")
    fi

    # If still empty or 0, use ps to find the process
    if [ -z "$PID" ] || [ "$PID" -eq 0 ]; then
        PID=$(ps -aux | grep "$SERVICE2" | grep -v grep | awk '{print $2}' | head -n 1)
    fi

    # If still 0, discard and print a message
    if [ -z "$PID" ] || [ "$PID" -eq 0 ]; then
        break
    else
        PORTS=$(sudo lsof -i -P -n | awk -v pid="$PID" '$2 == pid && /LISTEN/ {print $9}' | cut -d':' -f2 | sort -n | uniq)
    fi

        PORT=""
    for p in $PORTS; do
        if [ -z "$PORT" ]; then
            PORT="$p"
        else
            PORT="$PORT,$p"
        fi
    done

    # Now you can use the final PORT variable
    if [ -n "$PORT" ]; then
        echo "$SERVICE,$PORT" >> $OUTPUT_FILE
    fi
done


