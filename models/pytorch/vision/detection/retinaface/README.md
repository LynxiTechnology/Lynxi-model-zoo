# retinaface

模型来源：https://github.com/biubug6/Pytorch_Retinaface


## 用法

1. 从百度网盘下载依赖项mobilenet0.25_Final.pth, mobilenetV1X0.25_pretrain.tar并放在与此文档同级目录下
(https://pan.baidu.com/s/12h97Fy1RYuqMMIV-RpzdPg  Password: fstq)

2. 执行shell
```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
```

3. 结果概要
在目录golden/ 中生成所有必要信息，部分必要在终端显示
golden/
├── img_640_640.jpg        // input image
├── input.bin              // binary image by pickle
├── output_myself.bin      // output from lynxi model
├── output_target.bin      // output from original model
└── output_target.jpg      // output img from original model