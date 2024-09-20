#! /bin/bash

sudo apt-get update && sudo apt-get install -y \
    build-essential \
    python-is-python3 \
    tmux \
    htop \
    git \
    nodejs \
    bmon \
    p7zip-full \
    nfs-common


# Python dependencies
cat > $HOME/tpu_requirements.txt <<- EndOfFile
-f https://storage.googleapis.com/jax-releases/libtpu_releases.html
jax[tpu]
flax
optax
einops
--extra-index-url https://download.pytorch.org/whl/cpu
torch
transformers
datasets
tqdm
requests
typing-extensions
mlxu
sentencepiece
pydantic
fastapi
uvicorn
gradio
EndOfFile

pip install --upgrade pip
pip install --upgrade -r $HOME/tpu_requirements.txt
