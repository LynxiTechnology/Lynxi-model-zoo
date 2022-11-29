# yolov3_Caffe
    1.  模型来源：https://github.com/foss-for-synopsys-dwc-arc-processors/synopsys-caffe-models/tree/master/caffe_models/yolo_v3/caffe_model
    2.  测试模型：yolov3 


## TODO list
- [x] yolov3 @416x416
- [x] yolov3 @608x608 


## 用法
    1.  有需要可以调整 setting.cfg的配置，然后运行以下脚本
    2.  执行 1_prepare 时先将模型下载到当前目录下
    ```shell
        1_prepare.sh
        2_convert.sh
        3_test.sh
        4_detect.sh
    ```

## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，需使用 lyngor1.7.0 及以上版本，该模型可编译成abc模型
   2. 第1张推理速度不代表最终推理速度，需使用 SDK 1.7.0 及以上版本，模型性能建议用 c++ api
   3. 默认已装好 python 的 caffe 环境并导入


## FAQ
    1.  运行 ./1_prepare.sh 报错 TypeError: _open() got an unexpected keyword argument 'as_grey'
        【解决方法】：xx/caffe/python/caffe/io.py 中 skimage.io.imread 参数错误，as_grey 应修改为 as_gray，由于 scikit-image 的 0.17.2 版本修改了参数名称
    
    2.  若为 ubuntu16.04，需源码编译 caffe 并导入 caffe 环境；若为 Ubuntu18.04，输入 pip3 install caffe 安装
        1）caffe 源码 github 路径下载：git clone https://github.com/BVLC/caffe.git
        2）导入caffe 环境：export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
    
    3.  模型中含有 upsample 算子需参考如下链接添加该算子后执行 ./2_convert.sh，若没添加该算子会报错有不支持的算子
        1）caffe模型添加 upsample 算子参考：https://www.codenong.com/cs106677227/ 中的 <2.2 caffe升级支持yolov3> 这节
