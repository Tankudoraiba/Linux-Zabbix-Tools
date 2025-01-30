## Auth Fail Check template for Zabbix 7.0 LTS

This template is created with Zabbix Agent 2 in mind but it can be used with Zabbix Agent if paths are changed.  

### Instalation

1. Move auth_fail_check.conf from "plugins.d" to "/etc/zabbix/zabbix_agent2.d/plugins.d"  
2. sudo usermod -aG systemd-journal zabbix
3. systemctl restart zabbix_agent2
4. Import auth_fail_check_template.yaml to zabbix server  
