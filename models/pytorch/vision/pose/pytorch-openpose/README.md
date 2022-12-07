# pytorch-openpose
   1. 模型来源：https://github.com/Hzzone/pytorch-openpose.git


## 支持列表
   - [x] body_pose_model @184x184
   - [x] body_pose_model @184x200
   - [x] body_pose_model @184x328 

   - [x] hand_pose_model @184x184
   - [x] hand_pose_model @368x368
   - [x] hand_pose_model @552x552
   - [ ] hand_pose_model @736x736


## 用法
   1. 有需要可以调整setting.cfg，再执行以下脚本
   2. 推荐 lyngor+sdk 1.7.0及以上版本编译和测试
   ```shell
      1_prepare.sh
      2_convert.sh
      3_test.sh
      4_detect.sh
   ```

## 权重下载
   1. 原模型权重文件需要手动下载，请从以下链接手动下载pytorch models文件，并且放在model目录下
   2. 百度下载地址：https://pan.baidu.com/s/1IlkvuSi0ocNckwbnUe7j-g#list/path=%2F
   3. 谷歌下载地址：https://drive.google.com/drive/folders/1JsvI4M4ZTg98fmnCZLFM-3TeovnCRElG?usp=sharing

