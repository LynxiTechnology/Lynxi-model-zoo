#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import torch
import lynsetting
import lyngor as lyn
import numpy as np
import onnxruntime
import lynpy

def lyn_loss(output, lyn_output):
    return np.sqrt(np.sum( (np.float32(lyn_output)-np.float32(output))**2 )) \
            / np.sqrt(np.sum( np.float32(output)**2 ))

input = torch.rand(lynsetting.LYN_INPUT)

session = onnxruntime.InferenceSession("yolox_s.onnx")
ort_inputs = {session.get_inputs()[0].name: input.numpy()}
inname = [input.name for input in session.get_inputs()]

output1 = session.run(None, ort_inputs)

lyn_model = lynpy.Model(path='./build_model/Net_0')
lyn_in = lyn_model.input_tensor().from_numpy(input.numpy()).apu()
lyn_model(lyn_in)
output2 = lyn_model.output_list()[0][0].cpu()
print(output1[0].shape)
print(output2.numpy().shape)
loss = lyn_loss(output1[0], output2.numpy())
print(f'=======loss {loss}========')
