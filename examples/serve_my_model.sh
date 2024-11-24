#! /bin/bash

umask 000
LEV_ROOT=$(dirname "$(readlink -f $0)")/..

PYTHONPATH=${LEV_ROOT}:${LEV_ROOT}/src:${LEV_ROOT}/examples:$PYTHONPATH "$@"

# TPU specific flags to improve throughput
export LIBTPU_INIT_ARGS='--xla_jf_spmd_threshold_for_windowed_einsum_mib=0 --xla_tpu_spmd_threshold_for_allgather_cse=10000 --xla_enable_async_all_gather=true --xla_tpu_enable_latency_hiding_scheduler=true TPU_MEGACORE=MEGACORE_DENSE'

python -m EasyLM.models.llama.llama_serve \
    --mesh_dim='-1,8,1' \
    --dtype='bfloat16' \
    --llama.base_model='llama2_3b' \
    --load_checkpoint='trainstate_params::gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log/020dde1f9ea5464981aa022d89d09cff/streaming_train_state' \
    --tokenizer='openlm-research/open_llama_3b_v2' \
    --input_length=1024 \
    --seq_length=2048 \
    --lm_server.batch_size=4 \
    --lm_server.port=35009 \
    --lm_server.host='0.0.0.0' \
    --lm_server.pre_compile='all'
