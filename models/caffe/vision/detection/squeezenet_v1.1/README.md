# SqueezeNet_Caffe

模型来源：https://github.com/forresti/SqueezeNet


## TODO list
    1.  模型输入(1,3,227,227) 
    2.  可用于图像分类


## 用法

有需要可以调整setting.cfg的配置，然后运行以下脚本

如果1_prepare模型和代码无法下载，可以提前用 git clone 下载然后复制到本目录

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```

## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，需使用 lyngor1.1.0 及以上版本，该模型可编译成abc模型
   2. 第1张推理速度不代表最终推理速度
   3. 默认已装好 python 的 caffe 环境并导入


## FAQ
    1.  运行 ./1_prepare.sh 报错 TypeError: _open() got an unexpected keyword argument 'as_grey'
        【解决方法】：xx/caffe/python/caffe/io.py 中 skimage.io.imread 参数错误，as_grey 应修改为 as_gray，由于 scikit-image 的 0.17.2 版本修改了参数名称
    
    2.  若为 ubuntu16.04，需源码编译 caffe 并导入 caffe 环境；若为 Ubuntu18.04，输入 pip3 install caffe 安装
        1）caffe 源码 github 路径下载：git clone https://github.com/BVLC/caffe.git
        2）导入caffe 环境：export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
