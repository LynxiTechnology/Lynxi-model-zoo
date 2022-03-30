#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"


source setting.cfg

if [ ! -f "$model_file" ]; then
    wget $model_url

    pip install onnx==1.7.0
    pip install onnxruntime
fi

cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -