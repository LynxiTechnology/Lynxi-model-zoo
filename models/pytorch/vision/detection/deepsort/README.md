# deepsort-yolov3

模型来源：https://github.com/ZQPei/deep_sort_pytorch

## 支持列表
- [x] yolov3 @416x416
- [] yolov5m @640x640

## 用法

有需要可以调整setting.cfg的配置，然后运行以下脚本

如果1_prepare模型和代码无法下载，可以提前下载到本目录

使用本项目必须要下载 deepsort checkpoint 文件到当前目录下，checkpoint 下载地址：

```
https://drive.google.com/drive/folders/1xhG0kRH1EX5B9_Iz8gQJb7UNnn_riXi6
```

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```
