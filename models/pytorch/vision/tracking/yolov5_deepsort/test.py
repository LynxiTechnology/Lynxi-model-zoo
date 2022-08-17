import sys 
import os 
import numpy as np
import lynpy

argc = len(sys.argv)
if argc != 8:
    print('usage: python3 test.py <model_path1> <golden_input1> <golden_output1> <model_path2> <golden_input2> <golden_output2> <numpy_dtype>')
    assert(argc == 8)

numpy_dtype = sys.argv[7]
input_yolov5_shape = tuple(map(int, os.environ["YOLOV5_SHAPE"].split(","))) 
input_osnet_shape = tuple(map(int, os.environ["OSNET_SHAPE"].split(","))) 


def lyn_loss(golden, sample):
    return np.sqrt(
                np.sum( (np.float32(sample)-np.float32(golden))**2 ) \
                / np.sum( np.float32(golden)**2 )
            )


def infer(model_path, data):
    model = lynpy.Model(path=model_path)
    input = model.input_tensor().from_numpy(data).apu()
    output = model(input).cpu().numpy()
    return output


def run_yolov5():
    test_data = np.fromfile(sys.argv[2], dtype=np.dtype(numpy_dtype))
    model_data = test_data.reshape(input_yolov5_shape)    # add 
    model_data = model_data*255
    model_data = np.ascontiguousarray(model_data.transpose(0,2,3,1)).astype("uint8")
    golden = np.fromfile(sys.argv[3],  dtype=np.dtype(numpy_dtype))

    sample = infer(sys.argv[1], model_data)
    sample.dtype = np.dtype("float16")                     # add 
    loss = lyn_loss(sample, golden)
    print(f'=======[run_yolov5] test done, loss({loss})=======')


def run_osnet():
    test_data = np.fromfile(sys.argv[5], dtype=np.dtype(numpy_dtype))
    model_data = np.ascontiguousarray(test_data.reshape(input_osnet_shape).transpose(0,2,3,1)).astype("float16")   # add
    golden = np.fromfile(sys.argv[6],  dtype=np.dtype(numpy_dtype))

    sample = infer(sys.argv[4], model_data)
    sample.dtype = np.dtype("float16")                     # add 
    loss = lyn_loss(sample, golden)
    print(f'=======[run_osnet] test done, loss({loss})=======')


# 测试误差率 -----------------
run_yolov5()
run_osnet()