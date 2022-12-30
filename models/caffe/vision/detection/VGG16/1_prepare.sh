#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg


if [ ! -f "$cur_dir/eval_image.py" ]; then
    # apply patch test model and detection
    cd $cur_dir 
    git apply --reject ./patch/*.patch
fi

if [ ! -f "$model_file" ] || [ ! -f "$model_weights" ]; then
    echo "===== [Notice] read README.md to download model_file and model_weights ====="
    exit
fi

# generate golden before patch
cd $golden_dir && python3 generate.py $model_file $model_weights $input_shapes

# print original result
cd $cur_dir && python3 eval_image.py --proto $model_file --model $model_weights --image $golden_dir/bird.jpg