#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

# if [ ! -f "$model_file" ]; then
#     wget $model_url
# fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    # fixed torch 1.7.0 at first
    pip3 install torch==1.7.0 torchvision
    pip3 install -r requirements.txt
    
fi

cd $source_dir

git checkout 11ca4b0ff8cf92f02f90e115487b0beebbf3b89e

# generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python $source_dir/tools/demo.py image -n yolox-s -c $model_file --path $source_dir/assets/dog.jpg --conf 0.25 --nms 0.45 --tsize ${input_shapes##*"640,"} --save_result
cp -r $source_dir/YOLOX_outputs/yolox_s/vis_res/* $golden_dir/

# apply patch
cd $source_dir
git am ../patch/*.patch
cd $cur_dir