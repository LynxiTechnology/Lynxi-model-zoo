# Real-ESRGAN

模型来源：https://github.com/xinntao/Real-ESRGAN


## TODO list
- [ ] optimize for human faces
- [ ] optimize for texts
- [x] optimize for anime images
- [ ] support more scales
- [ ] support controllable restoration strength


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
   1. 执行 2_convert.sh 需安装 lyngor，推荐使用 lyngor1.0.5.0 版本
   2. 第1张推理速度不代表最终推理速度
