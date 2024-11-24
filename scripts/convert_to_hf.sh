#!/bin/bash

# Exit on error
set -e

# Source checkpoint path
SOURCE_CHECKPOINT="gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log/020dde1f9ea5464981aa022d89d09cff/streaming_train_state"

# Output directory in GCS
OUTPUT_DIR="gs://jsg-bucket/LLM/easyLM/llama2_3b/experiment_output/llama3-log/020dde1f9ea5464981aa022d89d09cff/hf_model"

# Create a local temporary directory
LOCAL_TMP_DIR="/tmp/hf_conversion"
mkdir -p $LOCAL_TMP_DIR

echo "Converting checkpoint to HuggingFace format..."
python -m EasyLM.models.llama.convert_easylm_to_hf \
    --load_checkpoint="trainstate_params::${SOURCE_CHECKPOINT}" \
    --output_dir="${LOCAL_TMP_DIR}"

echo "Copying converted files to GCS..."
gsutil -m cp -r "${LOCAL_TMP_DIR}/*" "${OUTPUT_DIR}/"

echo "Cleaning up..."
rm -rf "${LOCAL_TMP_DIR}"

echo "Conversion complete. Files are available at: ${OUTPUT_DIR}"
