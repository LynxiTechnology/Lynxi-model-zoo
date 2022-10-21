# ultralytics-yolov5

模型来源：https://github.com/ultralytics/yolov5/

发行版本：6.0

## 支持列表
- [x] yolov5s @640x640
- [x] yolov5m @640x640
- [x] yolov5l @640x640
- [ ] yolov5x @640x640

## 用法

有需要可以调整setting.cfg的配置，然后运行以下脚本

如果1_prepare模型和代码无法下载，可以提前下载到本目录

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```

## 注意事项
   1. 推荐使用lyngor1.5.0（20221017及以后版本）及sdk1.5.1（20221015及以后版本）
   2. 本案例使用python api，推理速度不是最终模型能力，建议使用c++ api测试
