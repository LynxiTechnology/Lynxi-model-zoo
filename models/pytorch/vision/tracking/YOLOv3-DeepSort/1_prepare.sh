#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -f "$detect_file" ]; then
    wget $detect_url --no-check-certificate
fi

if [ ! -f "$ckpt_file" ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "警告：没有 deepsort checkpoint 文件，请下载 checkpoint 文件"
    echo "下载地址：https://drive.google.com/drive/folders/1xhG0kRH1EX5B9_Iz8gQJb7UNnn_riXi6"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir
    git checkout 8cfe2467a4b1f4421ebf9fcbc157921144ffe7cf

    cd $cur_dir && mv $detect_file $source_dir/detector/YOLOv3/weight && mv $ckpt_file $source_dir/deep_sort/deep/checkpoint

    cd $source_dir && cd thirdparty 
    dir = $(pwd)
    rm -rf $dir/fast-reid
    git clone https://gitee.com/fanfansd/fast-reid.git

    cd fast-reid
    git checkout 4508251d7439c6c20e8e2d9573c6123b1f388cc5
fi

cd $source_dir
# apply patch
git apply --reject ../patch/*.patch
pip3 install ninja==1.10.2.3 mmdet==2.25.1 mmcv-full==1.6.1 yacs==0.1.8 termcolor==1.1.0 faiss-cpu==1.7.2 tabulate==0.8.10 tensorboard==2.9.1
pip3 install -r requirements.txt
cd $cur_dir
