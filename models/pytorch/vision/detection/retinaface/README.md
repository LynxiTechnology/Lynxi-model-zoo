# retinaface

模型来源：https://github.com/biubug6/Pytorch_Retinaface


## 用法

1. 从百度网盘下载依赖项mobilenet0.25_Final.pth, mobilenetV1X0.25_pretrain.tar并放在patch目录下
(https://pan.baidu.com/s/12h97Fy1RYuqMMIV-RpzdPg  Password: fstq)

2. 执行shell
```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```

3. 结果概要
在目录./Pytorch_Retinaface/dump_log中生成所有必要信息，部分必要在终端显示
├── input_myself.bin
├── logger.log
├── model_myself            // lynxi模型
├── output_myself.bin       // lynxi模型推理结果
├── output_onnx.bin
├── output_target.bin       // 开源模型推理结果
├── result_myself.jpg       // lynxi模型推理结果
├── result_target.jpg       // 开源代码推理结果
├── swlog
├── target_net.pth          // 开源代码生成的pytorch模型
├── target_net.sd
└── target_onnx.onnx