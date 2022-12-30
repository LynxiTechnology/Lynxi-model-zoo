#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg


if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    # apply patch modify code and test model
    git apply --reject ../patch/*.patch       

    # install models 
    pip3 install torch==1.7.0 torchvision==0.8.1 matplotlib -i https://pypi.tuna.tsinghua.edu.cn/simple/
fi

if [ ! -f "$model_file" ] || [ ! -f "$cur_dir/data/cifar-100-python.tar.gz" ]; then
    echo "===== [Notice] read README.md to download model_file and cifar100 data ====="
    echo "===== [Notice] 将权重文件 mobilenet-200-regular.pth 下载到当前目录下  ====="
    echo "===== [Notice] 新建 data 目录并将数据集 cifar-100-python.tar.gz 放入（或是自动创建data目标并下载数据集） ====="
    exit
fi

# generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes

# print original result
cd $cur_dir && python3 $source_dir/test.py -net mobilenet -weights $model_file         

