#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，请注意手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$golden_dir" ]; then
    mkdir "$golden_dir"
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir
    git checkout 5ee71dc10020403dc3def2bb68f9b77c40337ae2

    # fixed torch 1.7.0 at first
    pip3 install torch==1.7.0 torchvision
    pip3 install -r requirements.txt
fi

if [ ! -f "$model1" ] && [ ! -f "$model2" ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "请下载pytorch models文件,并且放在model目录下"
    echo "下载地址1:https://pan.baidu.com/s/1IlkvuSi0ocNckwbnUe7j-g#list/path=%2F"
    echo "下载地址2:https://drive.google.com/drive/folders/1JsvI4M4ZTg98fmnCZLFM-3TeovnCRElG?usp=sharing"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    exit
fi

# apply patch
cd $source_dir
git am ../patch/*.patch
cd $cur_dir

cd $source_dir
# # generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
python demo.py --savers $golden_dir

