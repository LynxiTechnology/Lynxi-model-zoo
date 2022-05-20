#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$source_dir" ]; then    # code first
    git clone $source_url
    cd $source_dir

    # fixed torch 1.7.0 at first
    pip3 install torch==1.7.0 torchvision==0.8.0 -i https://pypi.tuna.tsinghua.edu.cn/simple  
    pip3 install -r requirements.txt 
    python3 setup.py develop        # add 
fi

if [ ! -f "$model_file" ]; then
    # Specify directory 
    wget -P $source_dir/experiments/pretrained_models/ $model_url   
fi

cd $source_dir

# generate golden before patch   
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python3 $source_dir/inference_realesrgan.py -n RealESRGAN_x4plus_anime_6B -i $golden_dir/wolf_gray.jpg --fp32 -o $golden_dir 

# apply patch
git am ../patch/*.patch
cd $cur_dir