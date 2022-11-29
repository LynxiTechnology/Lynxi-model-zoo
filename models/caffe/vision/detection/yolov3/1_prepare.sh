#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg


if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    # apply patch fix bs 10 to 1 and add test demo 
    git apply --reject ../patch/*.patch
fi

if [ ! -f "$model_file" ] || [ ! -f "$model_weights" ]; then
    echo "===== read README.md to download model_file and model_weights ====="
    exit
fi

# generate golden before patch
cd $golden_dir && python3 generate.py $model_file $model_weights $input_shapes

# print original result
cd $source_dir && python3 detect_one.py --prototxt $model_file --caffemodel $model_weights --output $golden_dir/demo.jpg
echo "===== original result save in golden/demo.jpg ====="