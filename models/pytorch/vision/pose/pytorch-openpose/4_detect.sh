#!/bin/bash

source setting.cfg
cd $source_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "=========================测试torch模型========================="
python3 $source_dir/demo.py --savers $golden_dir

echo "=========================测试lynxi模型========================="
python3 $source_dir/lyn_demo.py --savers $golden_dir

echo "=========check image result in golden folder=========="