# YOLOX

模型来源：https://github.com/Megvii-BaseDetection/YOLOX/tree/main/demo/ONNXRuntime

发行版本：0.1.1rc0

## 支持列表
- [x] YOLOX-s @640x640
- [ ] YOLOX-m @640x640
- [ ] YOLOX-l @640x640
- [ ] YOLOX-x @640x640
- [ ] YOLOX-Darknet53 @640x640
- [ ] YOLOX-Nano @416x416
- [ ] YOLOX-Tiny @416x416

## 用法

有需要可以调整setting.cfg，再执行以下脚本

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
```


模型可以手动下载yolox_s.onnx
```
   https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.onnx
```