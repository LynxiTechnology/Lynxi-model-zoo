import sys 
import os 
import numpy as np
import lynpy

argc = len(sys.argv)
if argc != 5:
    print('usage: python3 test.py <model_path1> <golden_input1> <golden_output1> <data dtype>')
    assert(argc == 5)

numpy_dtype = sys.argv[4]
input_yolov5_shape = tuple(map(int, os.environ["YOLOV5_SHAPE"].split(","))) 


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

# 测试误差率 -----------------
run_yolov5()