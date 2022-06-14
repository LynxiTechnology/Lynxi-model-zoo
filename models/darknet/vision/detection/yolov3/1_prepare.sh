#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ">准备环境，如失败请手动下载<"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@"

source setting.cfg

if [ ! -f "$model_file" ]; then
    wget $model_url --no-check-certificate
fi

if [ ! -d "$source_dir" ]; then
    git clone $source_url

    # download package
    pip install tensorflow==1.15.0 keras==2.2.5
    pip install numpy opencv-python pillow matplotlib
    pip install h5py==2.9.0
fi

cd $source_dir

# support master 
git checkout e6598d13c703029b2686bc2eb8d5c09badf42992

export PYTHONPATH=$source_dir:$PYTHONPATH
#convert darknet to tensorflow
python3 $source_dir/convert.py $source_dir/$yolo_categories.cfg $model_file $cur_dir/$yolo_categories.h5

#apply patch
git am ../patch/*.patch
cd $cur_dir

# generate golden before patch
cd $golden_dir && python3 generate.py $model_file_h5 $input_shapes && cd -
python3 $source_dir/yolo_video.py --model_path $model_file_h5 --anchors_path $anchor_path --classes_path $classes_path --gpu_num 0 --image  --input_image_path $cur_dir/images/bus.jpg --output_image_path $golden_dir