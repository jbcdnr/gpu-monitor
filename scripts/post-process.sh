#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 GPU_MONITOR_DATA_PATH"
    exit
fi

GPU_MONITOR_DATA_PATH=$1
mkdir -p $GPU_MONITOR_DATA_PATH
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HOST=`hostname`

echo "Processing files $GPU_MONITOR_DATA_PATH/${HOST}_*.pre"


while true; do
    df | grep "/dev/sda1" > $GPU_MONITOR_DATA_PATH/${HOST}_status.csv
    free -m | grep "Mem" >> $GPU_MONITOR_DATA_PATH/${HOST}_status.csv
    #top -b -n 1 | grep %Cpu >> $GPU_MONITOR_DATA_PATH/${HOST}_status.csv
    ps -A -o pcpu | tail -n+2 | paste -sd+ | bc >> $GPU_MONITOR_DATA_PATH/${HOST}_status.csv
    nproc >> $GPU_MONITOR_DATA_PATH/${HOST}_status.csv

    python $SCRIPT_DIR/gpu-processes.py $GPU_MONITOR_DATA_PATH/${HOST}_processes.pre > $GPU_MONITOR_DATA_PATH/${HOST}_users.csv
    echo $(uptime | grep -o -P ': \K[0-9]*[,]?[0-9]*')\;$(nproc) > $GPU_MONITOR_DATA_PATH/${HOST}_cpus.csv
    tail -n 20 $GPU_MONITOR_DATA_PATH/${HOST}_gpus.pre > $GPU_MONITOR_DATA_PATH/${HOST}_gpus.csv
    tail -n 40 $GPU_MONITOR_DATA_PATH/${HOST}_processes.pre > $GPU_MONITOR_DATA_PATH/${HOST}_processes.csv

    sleep 10
done
