import lyngor as lyn 
import sys 

argc = len(sys.argv)
if argc != 7:
    print('usage: python3 convert.py <model_file1> <input_shapes1> <model_file2> <input_shapes2>')
    assert(argc == 7)

# convert yolov5s model to map（use lyngor 1.1.0 +）
from models.experimental import attempt_load  
model_file_yolov5 = sys.argv[1]
input_shapes_yolov5 = tuple(map(int, sys.argv[2].split(",")))  
output_dir_yolov5 = sys.argv[3]

model_yolov5 = attempt_load(model_file_yolov5, device="cpu", inplace=False, fuse=False)
model_yolov5.eval()

mod = lyn.DLModel()
mod.load(model_yolov5, model_type="Pytorch", inputs_dict={"data":input_shapes_yolov5},
                in_type="uint8", 
                out_type="float16",
                variance=(255,),
                transpose_axis=[(0,3,1,2)])   
offline_builder = lyn.Builder(target="apu")
offline_builder.build(mod.graph, mod.params, out_path=output_dir_yolov5)
print('###[lyn_build] convert model end!, save path is', output_dir_yolov5)


# convert osnet model to map
sys.path.insert(0, "Yolov5_StrongSORT_OSNet/strong_sort")
from strong_sort.deep.reid.torchreid.models import build_model
from strong_sort.deep.reid.torchreid.utils import load_pretrained_weights
model_file_osnet = sys.argv[4]
input_shapes = tuple(map(int, sys.argv[5].split(",")))  
input_shapes_osnet = (1,) + input_shapes[1:]                   # build shape
output_dir_osnet = sys.argv[6]

model_osnet = build_model(
                "osnet_x0_25",
                num_classes=1,
                pretrained=False,
                use_gpu=False
                )
model_osnet.eval()
load_pretrained_weights(model_osnet, model_file_osnet)

mod = lyn.DLModel()
mod.load(model_osnet, model_type="Pytorch", inputs_dict={"data":input_shapes_osnet},      # (1,3,256,128)
            in_type="float16", 
            out_type="float16",
            transpose_axis=[(0,3,1,2)])  
offline_builder = lyn.Builder(target="apu", map_batch=input_shapes[0])
offline_builder.build(mod.graph, mod.params, out_path=output_dir_osnet)
print('###[lyn_build] convert model end!, save path is', output_dir_osnet)