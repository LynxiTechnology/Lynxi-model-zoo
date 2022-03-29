#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

cur_dir=$(pwd)

source_url="https://github.com/ultralytics/yolov5.git"
source_dir="$cur_dir/yolov5"
model_url="https://github.com/ultralytics/yolov5/releases/download/v6.0/yolov5s.pt"
model_file="yolov5s.pt"
golden_dir="$cur_dir/golden"

if [ ! -f "$model_file" ]; then
    wget $model_url
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    # support v6.0
    git checkout v6.0

    # fixed torch 1.7.0 at first
    pip install torch==1.7.0 torchvision
    pip install -r requirements.txt

    # generate golden before patch
    export PYTHONPATH=$source_dir:$PYTHONPATH
    cd $golden_dir && python3 generate.py && cd -

    # apply patch
    git am ../patch/*.patch
    cd $cur_dir
fi

