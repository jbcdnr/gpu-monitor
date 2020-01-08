#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 GPU_MONITOR_DATA_PATH"
    exit
fi

GPU_MONITOR_DATA_PATH=$1
mkdir -p $GPU_MONITOR_DATA_PATH

HOST=`hostname`

echo "Logging processes in $GPU_MONITOR_DATA_PATH/${HOST}_processes.pre"

nvidia-smi \
    --format=csv,noheader,nounits \
    --query-compute-apps=timestamp,gpu_uuid,used_gpu_memory,process_name,pid -l 20 \
    > $GPU_MONITOR_DATA_PATH/${HOST}_processes.pre
