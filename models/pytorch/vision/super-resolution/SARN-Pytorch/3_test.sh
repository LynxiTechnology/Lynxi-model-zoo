#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

# test model sarn_fuse_se_all
python3 "$MODEL_VERIFY" "$output_dir_1/Net_0" $golden_dir/input_sarn_fuse_se_all.bin $golden_dir/output_sarn_fuse_se_all.bin "float16"

# test model sarn_fuse_se_all_bam
python3 "$MODEL_VERIFY" "$output_dir_2/Net_0" $golden_dir/input_sarn_fuse_se_all_bam.bin $golden_dir/output_sarn_fuse_se_all_bam.bin "float16"