# ultralytics-yolov5
   1. 模型来源：https://github.com/ultralytics/yolov5/
   2. 发行版本：6.0


## 支持列表
- [x] yolov5s @640x640
- [x] yolov5m @640x640
- [x] yolov5l @640x640
- [x] yolov5x @640x640 
- [x] yolov3  @640x640 


## 用法
   1. 有需要可以调整setting.cfg的配置，然后运行以下脚本
   2. 如果 1_prepare 模型和代码无法下载，可以提前下载到本目录
   ```shell
      1_prepare.sh
      2_convert.sh
      3_test.sh
      4_detect.sh
   ```


## 注意事项
   1. 推荐使用 lyngor1.6.0（20221103及以上版本）及 sdk1.6.0
   2. 本案例使用 python api，推理速度不是最终模型能力，建议使用 c++ api 测试
