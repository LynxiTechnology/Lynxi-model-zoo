#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

# 注意：如果 git 失败，需删除 Yolov5_StrongSORT_OSNet 目录后重新执行
if [ ! -d "$source_dir" ]; then    # code first
    git clone --recurse-submodules $source_url
    cd $source_dir

    # fixed torch 1.7.0 at first
    pip3 install torch==1.7.0 torchvision==0.8.1 -i https://pypi.tuna.tsinghua.edu.cn/simple  
    pip3 install -r requirements.txt 
fi

if [ ! -f "$model_file_yolov5" ]; then
    wget $model_url   
fi

cd $source_dir

# generate golden before patch   
export PYTHONPATH=$source_dir/yolov5:$PYTHONPATH      # fix bug
python3 $golden_dir/generate.py $model_file_yolov5 $input_shapes_yolov5  $model_file_osnet $input_shapes_osnet 

# test origin result
echo " ### Warning: don't ctrcl+c, next to apply patch"
python3 track.py --yolo-weights $model_file_yolov5 --strong-sort-weights $model_file_osnet --source $golden_dir/jiedao.mp4 --device cpu --show-vid

# apply patch
git apply --reject ../patch/*.patch
cd $cur_dir