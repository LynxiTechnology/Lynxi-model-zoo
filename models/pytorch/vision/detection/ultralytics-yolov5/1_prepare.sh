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

    # support v6.0
    git checkout v6.0

    # fixed torch 1.7.0 at first
    pip install torch==1.7.0 torchvision
    pip install -r requirements.txt
fi


cd $source_dir
# support v6.0
git checkout v6.0

# generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python3 $source_dir/detect.py --weights $model_file --project $golden_dir

# apply patch
git am ../patch/*.patch
cd $cur_dir