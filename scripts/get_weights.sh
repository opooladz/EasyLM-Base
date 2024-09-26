#!/bin/bash

# Create directory for the model
mkdir -p open_llama_3b_v2
cd open_llama_3b_v2

# Download model files
wget https://huggingface.co/openlm-research/open_llama_3b_v2/resolve/main/pytorch_model.bin
wget https://huggingface.co/openlm-research/open_llama_3b_v2/raw/main/config.json
wget https://huggingface.co/openlm-research/open_llama_3b_v2/raw/main/generation_config.json
wget https://huggingface.co/openlm-research/open_llama_3b_v2/raw/main/special_tokens_map.json
wget https://huggingface.co/openlm-research/open_llama_3b_v2/resolve/main/tokenizer.model
wget https://huggingface.co/openlm-research/open_llama_3b_v2/raw/main/tokenizer_config.json

echo "Download complete!"