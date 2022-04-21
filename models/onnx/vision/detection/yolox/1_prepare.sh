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

    # fixed torch 1.7.0 at first
    pip3 install torch==1.7.0 torchvision
    pip3 install -r requirements.txt
    pip3 install opencv-python
    pip3 install -v -e .
fi

cd $source_dir

git checkout 6513f769fa500b3c7ad23b90a91dcbd8402be330

# generate golden before patch
export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python3 $source_dir/demo/ONNXRuntime/onnx_inference.py -m $model_file -i $source_dir/assets/dog.jpg -s 0.3 --input_shape ${input_shapes##*"3,"}

# apply patch
cd $source_dir
git am ../patch/*.patch
cd $cur_dir
