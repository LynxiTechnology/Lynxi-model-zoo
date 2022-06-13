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
    pip install tensorflow==1.15.5 keras==2.2.5
    pip install numpy opencv-python pillow matplotlib
fi

cd $source_dir

# support master 
git checkout e6598d13c703029b2686bc2eb8d5c09badf42992

#apply patch
git am ../patch/*.patch
cd $cur_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
#convert darknet to tensorflow
python $source_dir/convert.py $source_dir/yolov3-tiny.cfg $model_file $cur_dir/yolov3-tiny.h5
python $source_dir/keras2pb.py --input_model=$cur_dir/yolov3-tiny.h5 --output_model=$converted_model --is_tiny=True

# generate golden before patch
cd $golden_dir && python3 generate.py $model_file $input_shapes && cd -
python $source_dir/yolo_video.py --model_path $model_file_h5 --anchors_path $anchor_path --classes_path $classes_path --gpu_num 0 --image  --input_image_path $cur_dir/images/bus.jpg --output_image_path $golden_dir