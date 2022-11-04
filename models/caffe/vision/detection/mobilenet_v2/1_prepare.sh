#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg


if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    # apply patch 
    git apply --reject ../patch/*.patch
fi

# caffe requirements.txt 
cd $cur_dir && pip3 install -r requirements.txt

# generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $model_weights $input_shapes

# print original result
cd $source_dir && python3 eval_image.py --proto $model_file --model $model_weights --image cat.jpg
