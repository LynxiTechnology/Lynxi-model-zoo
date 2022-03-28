#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"


model_url="https://bj.bcebos.com/paddle2onnx/model_zoo/pplcnet.onnx"
model_file="pplcnet.onnx"

if [ ! -f "$model_file" ]; then
    wget $model_url
fi

pip install onnx==1.7.0
pip install onnxruntime

cd golden && python3 generate.py && cd ..