# For Debian/Ubuntu
[ -f /var/log/mail.log ] && MAILLOG=/var/log/mail.log
# For RHEL/Centos
[ -f /var/log/maillog ] && MAILLOG=/var/log/maillog
# For Others
[ -f /var/log/postfix.log ] && MAILLOG=/var/log/postfix.log


/usr/sbin/pflogsumm ${MAILLOG} -h 0 -u 0 --bounce_detail=0 --deferral_detail=0 --reject_detail=0 --no_no_msg_size --smtpd_warning_detail=0 -d today > /etc/zabbix/zabbix_agent2.d/scripts/postfix_stats/maillog_summary