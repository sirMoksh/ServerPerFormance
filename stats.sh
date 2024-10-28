#!/bin/bash

# Total CPU usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}'

# Total memory usage
echo -e "\nTotal Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2 }'

# Total disk usage
echo -e "\nTotal Disk Usage:"
df -h | awk '$NF=="/"{printf "Used: %dGB (%s), Free: %dGB (%s)\n", $3, $5, $4, $5}'

# Top 5 processes by CPU usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Stretch goals
# OS version
echo -e "\nOS Version:"
lsb_release -a

# Uptime
echo -e "\nUptime:"
uptime -p

# Load average
echo -e "\nLoad Average:"
uptime

# Logged in users
echo -e "\nLogged in Users:"
who

# Failed login attempts
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l
