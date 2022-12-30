# mobilenet-pytorch
    1.  模型来源：https://github.com/weiaicunzai/pytorch-cifar100.git
    2.  预训练下载模型及cifar100数据地址：链接：https://pan.baidu.com/s/1FbDgNs1S_YvuAVvBVGg91Q 提取码：2022


## 模型常用输入形状
    - [x] mobilenet @32x32
    - [x] mobilenet @112x112


## 用法
    1.  有需要可以调整setting.cfg的配置，然后运行以下脚本
    2.  在执行 1_prepare 前，需提前下载好预训练好的 mobilenet 权重，放在同目录下，然后依次执行如下
```shell
    1_prepare.sh
    2_convert.sh
    3_test.sh
    4_detect.sh
```


## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，需使用 lyngor1.7.0 及以上版本，该模型可编译成abc模型
   2. 第1次推理速度不代表最终推理速度，需使用 SDK 1.7.0 及以上版本

