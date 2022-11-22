# keras-yolo3
   模型来源：https://github.com/qqwweee/keras-yolo3


## support model shape and model type 
- [x] 416x416   yolov3.weights


## 用法
   1. 有需要可以调整 setting.cfg 的配置，然后运行以下脚本
   2. 如果 1_prepare 代码无法下载，可以提前下载到本目录，同时将判断去掉
   3. 依次执行如下脚本
   ```shell
      1_prepare.sh
      2_convert.sh
      3_test.sh
      4_detect.sh
   ```

## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，推荐使用 lyngor1.7.0 及以上版本，sdk1.7.0及以上版本
   2. 第1张推理速度不代表最终推理速度，若要体现转换后模型性能建议用 c++ api
