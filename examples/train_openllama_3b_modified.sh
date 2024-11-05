#! /bin/bash

# This is the example script to fine-tune the Open LLaMA 3B v2 model on a TPU v4-64 pod.
# To use this on TPU pod, you need to run this script on every host in a TPU pod.

umask 000
LEV_ROOT=$(dirname "$(readlink -f $0)")/..

# Set up PYTHONPATH to include necessary directories
PYTHONPATH=${LEV_ROOT}:${LEV_ROOT}/src:${LEV_ROOT}/examples:$PYTHONPATH "$@"

# TPU specific flags to improve training throughput
export LIBTPU_INIT_ARGS='--xla_jf_spmd_threshold_for_windowed_einsum_mib=0 --xla_tpu_spmd_threshold_for_allgather_cse=10000 --xla_enable_async_all_gather=true --xla_tpu_enable_latency_hiding_scheduler=true TPU_MEGACORE=MEGACORE_DENSE'

# Run the training script with overridden mesh_dim
python -m EasyLM.models.llama.llama_train \
    --mesh_dim='-1,8,1' \
    --dtype='bfloat16' \
    --total_steps=2000000 \
    --log_freq=500 \
    --save_model_freq=5000 \
    --save_milestone_freq=50000 \
    --eval_steps=5 \
    --load_llama_config='3b' \
    --llama.base_model='llama2_3b' \
    --update_llama_config='' \
    --load_dataset_state='' \
    --load_checkpoint='params::gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log/c1342ca367bc439095c2f629c88ff561/streaming_train_state' \
    --tokenizer='openlm-research/open_llama_3b_v2' \
    --optimizer.type='adamw' \
    --optimizer.adamw_optimizer.weight_decay=0.01 \
    --optimizer.adamw_optimizer.lr=1e-3 \
    --optimizer.adamw_optimizer.end_lr=3e-5 \
    --optimizer.adamw_optimizer.lr_warmup_steps=0 \
    --optimizer.adamw_optimizer.lr_decay_steps=250000 \
    --train_dataset.type='huggingface' \
    --train_dataset.text_processor.fields='text' \
    --train_dataset.huggingface_dataset.path='HuggingFaceFW/fineweb-edu' \
    --train_dataset.huggingface_dataset.streaming=True \
    --train_dataset.huggingface_dataset.seq_length=2048 \
    --train_dataset.huggingface_dataset.batch_size=128 \
    --train_dataset.huggingface_dataset.split='train' \
    --train_dataset.huggingface_dataset.name='sample-100BT' \
    --eval_dataset.type='huggingface' \
    --eval_dataset.text_processor.fields='text' \
    --eval_dataset.huggingface_dataset.path='HuggingFaceFW/fineweb-edu' \
    --eval_dataset.huggingface_dataset.streaming=True \
    --eval_dataset.huggingface_dataset.seq_length=2048 \
    --eval_dataset.huggingface_dataset.batch_size=128 \
    --eval_dataset.huggingface_dataset.split='train' \
    --eval_dataset.huggingface_dataset.name='sample-10BT' \
    --checkpointer.save_optimizer_state=True \
    --logger.online=True \
    --logger.prefix='EasyLM' \
    --logger.project="open_llama_3b_v2" \
    --logger.output_dir="gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log" \
    --logger.wandb_dir="/dev/shm/experiment_output/open_llama_3b_v2" \
|& tee $HOME/output.txt
