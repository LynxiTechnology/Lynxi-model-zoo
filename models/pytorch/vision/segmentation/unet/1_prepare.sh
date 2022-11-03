#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$source_dir" ]; then    # code first
    git clone $source_url
    cd $source_dir
    git checkout v3.0              # model is v3.0

    # for lyngor1.6.0 install
    pip3 install torch==1.7.0 torchvision==0.8.1 numpy==1.16.6 -i https://pypi.tuna.tsinghua.edu.cn/simple  
    pip3 install -r requirements.txt 
fi

if [ ! -f "$model_file" ]; then
    wget -P $source_dir $model_url  # add to Pytorch-UNet dir
fi

# generate golden before patch   
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes 
cd $source_dir && python3 predict.py --model $model_file -i $golden_dir/car_256.jpg -o $golden_dir/car_pytroch.jpg 

# apply patch
git apply --reject ../patch/*.patch