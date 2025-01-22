## Postfix Stats Active template for Zabbix 7.0 LTS

This template is created with Zabbix Agent 2 in mind but it can be used with Zabbix Agent if paths are changed.  

### Instalation

1. Move folder "scripts" with content to "/etc/zabbix/zabbix_agent2.d"  
2. Move postfix_stats.conf from "plugins.d" to "/etc/zabbix/zabbix_agent2.d/plugins.d"  
3. chmod +x /etc/zabbix/zabbix_agent2.d/scripts/*  
4. chown -R zabbix:zabbix /etc/zabbix/zabbix_agent2.d  
5. apt install pflogsumm or dnf install postfix-perl-scripts
6. move cronfile "generate_pflogsumm" to /etc/cron.d
7. systemctl restart zabbix_agent2
8. Import postfix_stats_template.yaml to zabbix server  
