# YOLOX

模型来源：https://github.com/Megvii-BaseDetection/YOLOX

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
   4_detect.sh
```

模型可以手动下载yolox_s.pth
```
   https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth
```

如果修改./yolox/models/yolo_pafpn.py第32行：
self.upsample = nn.Upsample(scale_factor=2, mode="nearest")
为：
self.upsample = nn.Upsample(scale_factor=2, mode="bilinear",align_corners=True)
能得到更高的检测精确度，loss大约为0.3%