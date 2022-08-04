#!/bin/bash
source setting.cfg
cd ../../../../../ && source envsetup.sh && cd -

# export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

cd $source_dir

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">下载测试视频中，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

if [ ! -f "MOT16-04-raw.webm" ]; then
    wget https://motchallenge.net/sequenceVideos/MOT16-04-raw.webm
fi 

if (($display == 0)); then
    python3 lyninference.py MOT16-04-raw.webm --cpu
else
    python3 lyninference.py MOT16-04-raw.webm --cpu --display
fi

echo "======output images to result/ folder, original result in golden folder======="