# Pytorch-UNet
   源码位置：https://github.com/milesial/Pytorch-UNet/tree/v3.0


## support model shape (plan)
- [x] 128 * 128
- [ ] 256 * 256
- [ ] 512 * 512


## 用法
   1. 有需要可以调整setting.cfg的配置，然后运行以下脚本
   2. 如果 1_prepare 中模型无法下载，可以提前下载到 Pytorch-UNet 目录下
   ```shell
      1_prepare.sh
      2_convert.sh
      3_test.sh
      4_detect.sh
   ```


## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，推荐使用 lyngor1.5.1及以上版本
   2. 在板卡推理推荐使用 driver+sdk1.5.0 及以上版本，python的demo不能代表模型的最终推理速度，建议使用c++ api
   
