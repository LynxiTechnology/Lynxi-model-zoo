#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$source_dir" ]; then    # code first
    git clone $source_url
    cd $source_dir

    # fix bug and apply patch
    git apply --reject ../patch/*.patch

    # add test pic and delete low for demo
    rm $source_dir/data/eval/low/low
    cp $golden_dir/test.png $source_dir/data/eval/low/
    cp $golden_dir/test.png $source_dir/data/eval/high/
    
    # install models
    pip3 install \
        torch==1.7.0 torchvision==0.8.0 opencv-python-headless==4.5.5.64 \
        numpy==1.16.6 tqdm==4.62.2 scikit-image==0.17.2 \
        -i https://pypi.tuna.tsinghua.edu.cn/simple  
fi

export PYTHONPATH=$source_dir:$PYTHONPATH

# generate golden 
# model sarn_fuse_se_all.pth
cd $golden_dir && python3 generate.py $model_file_1 $input_shapes  
cd $source_dir && python3 eval_sarn_se.py --use_gpu 0 --checkpoint_dir $model_file_1 

# # model sarn_fuse_se_all_bam.pth
cd $golden_dir && python3 generate.py $model_file_2 $input_shapes 
cd $source_dir && python3 eval_sarn_se_bam.py --use_gpu 0 --checkpoint_dir $model_file_2

