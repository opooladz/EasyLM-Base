#!/bin/bash

# Create a directory for the model
mkdir -p open_llama_3b_v2_easylm
cd open_llama_3b_v2_easylm

# Download the EasyLM format model file
wget https://huggingface.co/openlm-research/open_llama_3b_v2_easylm/resolve/main/open_llama_3b_v2_easylm

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Download complete!"
    
    # Upload the file to your GCS bucket
    gsutil cp open_llama_3b_v2_easylm gs://jsg-bucket/open_llama_3b_v2_easylm/
    
    # Check if the upload was successful
    if [ $? -eq 0 ]; then
        echo "Upload to GCS complete!"
    else
        echo "Failed to upload to GCS."
    fi
else
    echo "Download failed."
fi