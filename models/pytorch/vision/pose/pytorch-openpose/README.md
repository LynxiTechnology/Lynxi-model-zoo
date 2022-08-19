# pytorch-openpose

模型来源：https://github.com/Hzzone/pytorch-openpose.git


## 支持列表

- [x] body_pose_model @184x200

注意，原body_pose模型网络输入尺寸不固定，因此在编译过程中将输入尺寸固定为184x200作为样例
实际应用中，可根据应用场景的要求改变输入尺寸并编译模型

- [x] hand_pose_model @184x184
- [x] hand_pose_model @368x368
- [ ] hand_pose_model @552x552
- [ ] hand_pose_model @736x736


## 用法

有需要可以调整setting.cfg，再执行以下脚本

```shell
   1_prepare.sh
   2_convert.sh
   3_test.sh
   4_detect.sh
```

## 权重下载

原模型权重文件需要手动下载，请从以下链接手动下载pytorch models文件,并且放在model目录下

下载地址1:https://pan.baidu.com/s/1IlkvuSi0ocNckwbnUe7j-g#list/path=%2F
下载地址2:https://drive.google.com/drive/folders/1JsvI4M4ZTg98fmnCZLFM-3TeovnCRElG?usp=sharing


