# Lynxi-model-zoo

![pic](https://user-images.githubusercontent.com/102273123/160040336-05dab1eb-088f-4204-ba8d-352818c6b5c4.png)

本目录主要汇集了由灵汐科技完成软适配的开源深度学习模型。在各模型文件夹下，用户可以找到配套的适配、转换、测试代码，也可基于此修改和训练模型，并部署到灵汐平台。

# 环境准备

该工程需要依赖灵汐软硬件，编译转换需要Lyngor，测试需要SDK和硬件，请提前联系销售/售前获取并安装。模型在转换过程中需要安装对应的python库环境，因此强烈推荐安装virtualenv，在python虚拟环境中进行验证。
- [x] python3.6
- [ ] virtualenv
- [x] lyngor
- [x] lynsdk
- [x] lyndriver

## 安装

``` shell
git clone https://github.com/LynxiTechnology/Lynxi-model-zoo.git
cd Lynxi-model-zoo

# 创建并激活虚拟环境
virtualenv venv
source venv/bin/activate

# 获取并安装lyngor
pip install lyngor-x.x.x.x-cp36-cp36m-linux_x86_64.whl
```

## 测试

请参考子目录下的说明进行