#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -d "$source_dir" ]; then
    git clone $source_url
    cd $source_dir

    git checkout 7e8b0d312162f335785fb5dcfa1df29a75a1783a

    pip install torch==1.7.0 torchvision
fi

cd $source_dir

git checkout 7e8b0d312162f335785fb5dcfa1df29a75a1783a

# apply patch
git am ../patch/*.patch
cd $cur_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python3 $source_dir/detect.py -n $model_file -m $source_dir/examples/simple/img2.jpg -i $input_shapes -l $source_dir/examples/simple/labels_map.txt -s 1000

echo "====== original classification result ======="
