
import torch
from torch.utils.mobile_optimizer import optimize_for_mobile
#from fairseq.models import TransformerModelBase
from fairseq import checkpoint_utils, distributed_utils, options, tasks, utils
from fairseq.models.transformer.transformer_legacy import TransformerModel
#from fairseq import TransformerModel
from fairseq.models.transformer.transformer_base import (
    TransformerModelBase,
)
model_path="../model/checkpoint_best.pt"
arg_overrides=None
state = checkpoint_utils.load_checkpoint_to_cpu(model_path, arg_overrides)
#models, _model_args = checkpoint_utils.load_model_ensemble(model_path)

tf_model="../tf_mode.pt"
model=torch.load(tf_model)#这里已经不需要重构模型结构了，直接load就可以
model.eval()
print('tf_model',type(model))

model_dynamic_quantized = model #torch.quantization.quantize_dynamic(model, qconfig_spec={torch.nn.Linear}, dtype=torch.float16)
#model_dynamic_quantized = torch.quantization.quantize_dynamic(model, qconfig_spec={torch.nn.Linear}, dtype=torch.qint8)
prev_output_tokens=None
traced_model = torch.jit.script(model_dynamic_quantized)
optimized_traced_model = optimize_for_mobile(traced_model)
optimized_traced_model._save_for_lite_interpreter("zy_bf16.ptl")
exit(0)




