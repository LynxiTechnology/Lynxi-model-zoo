
import lyngor as lyn 
import sys 

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 convert.py <model_file> <input_shapes> <output_dir>')
    assert(argc == 4)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))
output_dir = sys.argv[3]

model = lyn.DLModel()
model.load(model_file, model_type="Keras", inputs_dict={"input_1":input_shapes},
                in_type="float16", 
                out_type="float16")
offline_builder = lyn.Builder(target="apu")
offline_builder.build(model.graph, model.param, out_path=output_dir)
print('###[lyn_build] model build end! save out_path is ', output_dir)