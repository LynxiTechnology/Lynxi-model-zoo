#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import lyngor as lyn
import lynsetting

dlmodel = lyn.DLModel()
dlmodel.load("yolox_s.onnx", model_type='ONNX',
            inputs_dict={'images': lynsetting.LYN_INPUT})

#使用 lyn.Builder()接口创建 Builder。
builder = lyn.Builder(target='apu', is_map=True)
#使用 builder()方法编译计算图 graph，并保存。
builder.build(dlmodel.graph, dlmodel.params, out_path="./build_model")