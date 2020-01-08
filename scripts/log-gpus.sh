#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 GPU_MONITOR_DATA_PATH"
    exit
fi

GPU_MONITOR_DATA_PATH=$1
mkdir -p $GPU_MONITOR_DATA_PATH

HOST=`hostname`

echo "Logging GPUs in $GPU_MONITOR_DATA_PATH/${HOST}_gpus.pre"

mkdir -p $GPU_MONITOR_DATA_PATH

nvidia-smi \
    --format=csv,noheader,nounits \
    --query-gpu=index,uuid,name,memory.used,memory.total,utilization.gpu,utilization.memory,temperature.gpu,timestamp -l 20 \
    > $GPU_MONITOR_DATA_PATH/${HOST}_gpus.pre
