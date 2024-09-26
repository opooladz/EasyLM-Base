#!/bin/bash

# Create directory for the model
mkdir -p open_llama_3b_v2_easylm
cd open_llama_3b_v2_easylm

# Download the EasyLM format model file
wget https://huggingface.co/openlm-research/open_llama_3b_v2_easylm/resolve/main/open_llama_3b_v2_easylm

# Download the tokenizer file (which is still needed)
wget https://huggingface.co/openlm-research/open_llama_3b_v2/resolve/main/tokenizer.model

echo "Download complete!"