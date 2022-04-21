#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -f "$model_file" ]; then
    wget $model_url
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    git checkout master

    # download package
    pip install tensorflow==1.15.5 keras==2.2.5
    pip install numpy opencv-python pillow
fi


cd $source_dir
# support master
git checkout 4974156fd8962a5610ec6d34327788b2f2ec2b42

# apply patch
git am ../patch/*.patch
cd $cur_dir