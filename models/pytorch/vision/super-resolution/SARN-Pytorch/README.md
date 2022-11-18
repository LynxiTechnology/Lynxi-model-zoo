# SARN-Pytorch
   模型来源：https://github.com/weixinxu666/SARN


## support model shape and modle (plan)
- [x] 128x128  sarn_fuse_se_all.pth 和 sarn_fuse_se_all_bam.pth
- [ ] 256x256  sarn_fuse_se_all.pth 和 sarn_fuse_se_all_bam.pth
- [ ] 512x512  sarn_fuse_se_all.pth 和 sarn_fuse_se_all_bam.pth


## 用法
   1. 有需要可以调整setting.cfg的配置，然后运行以下脚本
   2. 如果 1_prepare 代码无法下载，可以提前下载到本目录
   3. 依次执行如下脚本
   ```shell
      1_prepare.sh
      2_convert.sh
      3_test.sh
      4_detect.sh
   ```

## 注意事项
   1. 执行 2_convert.sh 需安装 lyngor，推荐使用 lyngor1.2.0 版本，当前是支持 非abc模型编译
   2. 第1张推理速度不代表最终推理速度，若要体现转换后模型性能建议用 c++ api
