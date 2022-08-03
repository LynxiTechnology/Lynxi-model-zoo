# Yolov5_Deepsort

模型原始来源：https://github.com/mikel-brostrom/Yolov5_StrongSORT_OSNet


## TODO list
   1. 检测部分 yolov5s 模型输入 (1,3,640,640)
   2. 跟踪部分 osnet_x0_25_msmt17.pth 模型输入 (12,3,256,128)


## 用法
   1. 有需要可以调整setting.cfg的配置，然后运行以下脚本
   2. 如果1_prepare代码无法下载，可以提前 git clone 到本目录；模型可手动下载到本目录

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```
注意：需按照步骤依次执行


## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，需使用 lyngor1.1.0 及以上版本
   2. 第1张推理速度不代表最终推理速度
   3. 默认使用1颗芯片推理，可以在setting.cfg 配置2颗芯片分别推理yolov5s和osnet模型
