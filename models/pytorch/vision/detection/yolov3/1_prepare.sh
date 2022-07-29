#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -f "$detect_file" ]; then
    wget $detect_url --no-check-certificate
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir
    git checkout 8cfe2467a4b1f4421ebf9fcbc157921144ffe7cf

    cd $cur_dir && mv $detect_file $source_dir/detector/YOLOv3/weight
fi

cd $source_dir
# apply patch
git apply --reject ../patch/*.patch
pip3 install -r requirements.txt
cd $cur_dir