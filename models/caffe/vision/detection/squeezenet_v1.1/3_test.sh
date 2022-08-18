
#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg


# test abc model
python3 $cur_dir/test.py \
    $output_dir/Net_0 $golden_dir/input.bin $golden_dir/output.bin \
    $input_shapes "float32"