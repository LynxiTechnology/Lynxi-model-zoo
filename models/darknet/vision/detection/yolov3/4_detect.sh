#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

cd $cur_dir

if [ ! -d "$demo_output" ]; then
    mkdir $demo_output
fi

export PYTHONPATH=$source_dir:$PYTHONPATH
python3 $source_dir/lyndetect.py --input_shape "${input_shapes:2:7}" --image_path $image_path --model $output_dir/Net_0 --anchors $anchor_path --classes_path $classes_path --output_dir $demo_output

echo "======output images to demo_output folder, original result in golden folder======="