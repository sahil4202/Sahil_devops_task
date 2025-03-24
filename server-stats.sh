#!/bin/bash
# Get system information
OS_VERSION=$(cat /etc/os-release | grep -E '^PRETTY_NAME=' | cut -d '"' -f2)
UPTIME=$(uptime -p)
LOAD_AVG=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
LOGGED_IN_USERS=$(who | wc -l)
FAILED_LOGINS=$(cat /var/log/auth.log 2>/dev/null | grep 'Failed password' | wc -l)
# CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
# Memory usage
MEMORY=$(free -m | awk 'NR==2{printf "Used: %s MB, Free: %s MB (%.2f%% Used)\n", $3, $4, $3*100/$2}')
# Disk usage
DISK=$(df -h / | awk 'NR==2{printf "Used: %s, Free: %s (%.2f%% Used)\n", $3, $4, $5}')
# Top 5 processes by CPU usage
TOP_CPU=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -6)
# Top 5 processes by memory usage
TOP_MEM=$(ps -eo pid,comm,%mem --sort=-%mem | head -6)
# Print the results
echo "===== SERVER PERFORMANCE STATS ====="
echo "OS Version: $OS_VERSION"
echo "Uptime: $UPTIME"
echo "Load Average: $LOAD_AVG"
echo "Logged-in Users: $LOGGED_IN_USERS"
echo "Failed Login Attempts: $FAILED_LOGINS"
echo "-------------------------------------"
echo "CPU Usage: $CPU_USAGE"
echo "Memory Usage: $MEMORY"
echo "Disk Usage: $DISK"
echo "-------------------------------------"
echo "Top 5 Processes by CPU Usage:"
echo "$TOP_CPU"
echo "-------------------------------------"
echo "Top 5 Processes by Memory Usage:"
echo "$TOP_MEM"
echo "====================================="
