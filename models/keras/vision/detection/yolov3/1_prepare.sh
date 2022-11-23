#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$source_dir" ]; then    # code first
    git clone $source_url

    #  for to run demo and to bilinear 
    cd $source_dir && git apply --reject ../patch/0001-run-demo-and-to-bilinear.patch
fi

# install models
pip3 install \
    keras==2.2.5 tensorflow==1.14.0 numpy==1.16.6 h5py==2.10.0 \
    Pillow==8.4.0 matplotlib==3.3.4 \
    -i https://pypi.tuna.tsinghua.edu.cn/simple  

if [ ! -f "$model_file" ]; then
    # download yolov3.weights 
    cd $source_dir
    wget $model_url --no-check-certificate 
    python convert.py yolov3.cfg yolov3.weights model_data/yolo.h5
fi

# run demo
cd $source_dir && python3 yolo_video.py --image --input $golden_dir/mot15.jpg --output $golden_dir/demo.jpg  

# generate golden 
cd $golden_dir && python3 generate.py $model_file $input_shapes  

# patch for run lynxi model test
cd $source_dir && git apply --reject ../patch/0002-add-lynxi-model-test.patch




