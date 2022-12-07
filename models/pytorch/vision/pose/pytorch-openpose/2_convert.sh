#!/bin/bash

source setting.cfg
cd $source_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "=========================编译body模型========================="
python3 $source_dir/lyncompile_body_model.py 
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "=========================编译hand模型========================="
python3 $source_dir/lyncompile_hand_model.py 