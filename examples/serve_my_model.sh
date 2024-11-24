#! /bin/bash

# Allow external connections by binding to 0.0.0.0 instead of localhost
python -m EasyLM.models.llama.llama_serve \
    --load_llama_config='3b' \
    --load_checkpoint='trainstate_params::gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log/020dde1f9ea5464981aa022d89d09cff/streaming_train_state' \
    --tokenizer='openlm-research/open_llama_3b_v2' \
    --mesh_dim='1,-1,1' \
    --dtype='bf16' \
    --input_length=1024 \
    --seq_length=2048 \
    --lm_server.batch_size=4 \
    --lm_server.port=35009 \
    --lm_server.host='0.0.0.0' \
    --lm_server.pre_compile='all'
