#!/bin/bash

source setting.cfg
cd $source_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "=========================测试body模型========================="
python3 $source_dir/lyn_inference_body_model.py
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "=========================测试hand模型========================="
python3 $source_dir/lyn_inference_hand_model.py 