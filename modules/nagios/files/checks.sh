#!/bin/sh
NAGIOS=/usr/lib/nagios/plugins

# Simple Disk Space Check
$NAGIOS/check_disk -w 75 -c 90

# Load Check
$NAGIOS/check_load -w 3,2,1 -c 6,4,2

# MySQL Running?
$NAGIOS/check_procs -w 1:1 -c 1:1 -C mysqld

# NGINX Running?
$NAGIOS/check_procs -w 2:10 -c 2:10 -C nginx

# PHP CGI Running?
$NAGIOS/check_procs -w 16:16 -c 10:22 -C php-cgi
