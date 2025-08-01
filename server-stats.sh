#!/bin/bash

# === CPU Usage ===

STAT=$(head -n1 /proc/stat | awk '{for(i=2;i<=6;i++) printf $i " "; print ""}')
TOTAL_TIME=$(echo $STAT | awk '{value=0; for(i=1;i<=NF;i++) value+=$i; print value}')
IDLE_TIME=$(echo $STAT | awk '{value=0; for(i=4;i<=5;i++) value+=$i; print value}')

sleep 1

STAT2=$(head -n1 /proc/stat | awk '{for(i=2;i<=6;i++) printf $i " "; print ""}')
TOTAL_TIME2=$(echo $STAT2 | awk '{value=0; for(i=1;i<=NF;i++) value+=$i; print value}')
IDLE_TIME2=$(echo $STAT2 | awk '{value=0; for(i=4;i<=5;i++) value+=$i; print value}')

DELTA_TOTAL=$(echo "$TOTAL_TIME2 - $TOTAL_TIME" | bc -l)
DELTA_IDLE=$(echo "$IDLE_TIME2 - $IDLE_TIME" | bc -l)

CPU_USAGE=$(echo "100 * ($DELTA_TOTAL - $DELTA_IDLE) / $DELTA_TOTAL" | bc -l)

echo "=====CPU====="
printf "CURRENT CPU USAGE: %.2f%%\n" "$CPU_USAGE"
printf "\n"

# === MEM Usage ===

MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))

MEM_USAGE_PERCENT=$(echo "scale=2; 100 * $MEM_USED / $MEM_TOTAL" | bc)
MEM_AVAILABLE_PERCENT=$(echo "scale=2; 100 * $MEM_AVAILABLE / $MEM_TOTAL" | bc)

MEM_USAGE_GB=$(echo "scale=2; $MEM_USED / 1024 / 1024" | bc)
MEM_AVAILABLE_GB=$(echo "scale=2; $MEM_AVAILABLE / 1024 / 1024" | bc)

echo "=====MEMORY====="
echo "USED MEMORY: ${MEM_USAGE_GB}GB"
printf "USED MEMORY (%%): %.2f%%\n" "$MEM_USAGE_PERCENT"
echo "FREE MEMORY: ${MEM_AVAILABLE_GB}GB"
printf "FREE MEMORY (%%): %.2f%%\n" "$MEM_AVAILABLE_PERCENT"
printf "\n"

# === DISK Usage ===

DISK_DATA=$(df -k / | awk 'NR==2')
DISK_USED_PERCENT=$(echo "$DISK_DATA" | awk '{print $5}')
DISK_USED_GB=$(df -h / | awk 'NR==2 {print $3}')
DISK_AVAIL_GB=$(df -h / | awk 'NR==2 {print $4}')

echo "=====DISK====="
echo "USED DISK SPACE: $DISK_USED_GB"
echo "FREE DISK SPACE: $DISK_AVAIL_GB"
printf "USED DISK SPACE (%%): %s\n" "$DISK_USED_PERCENT"
printf "\n"

# === Top 5 Processes by CPU ===

echo "=====TOP 5 PROCESSES BY CPU====="
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
printf "\n"

# === Top 5 Processes by MEM ===

echo "=====TOP 5 PROCESSES BY MEMORY====="
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
printf "\n"

