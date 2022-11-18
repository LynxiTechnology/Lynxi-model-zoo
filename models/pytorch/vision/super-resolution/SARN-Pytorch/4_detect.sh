#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir
export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

# detect sarn_fuse_se_all model
python3 $source_dir/eval_sarn_se_lynxi.py --use_gpu 0 --checkpoint_dir $output_dir_1

# detect sarn_fuse_se_all_bam model
python3 $source_dir/eval_sarn_se_bam_lynxi.py --use_gpu 0 --checkpoint_dir $output_dir_2

echo "======output images to SARN/results/lol folder, original result in golden folder======="