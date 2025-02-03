import json

# File containing the port and service list
port_file = "/etc/zabbix/zabbix_agent2.d/scripts/service_status/tmp/port_statuses.txt"

def parse_port_file(file_path):
    data = []
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            # Skip empty lines or lines that do not contain a comma
            if not line or ',' not in line:
                continue
            service, ports = line.split(',', 1)  # Split only on the first comma
            port_list = ports.split(',')  # Split the multiple ports
            
            # Create an entry for each port
            for port in port_list:
                data.append({
                    "{#SERVICENAME}": service,
                    "{#PORT}": port.strip()  # Remove any extra spaces
                })
    return data

def create_discovery_data():
    ports = parse_port_file(port_file)
    return json.dumps({
        "data": ports
    })

if __name__ == "__main__":
    print(create_discovery_data())

