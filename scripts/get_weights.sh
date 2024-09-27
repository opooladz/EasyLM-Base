#!/bin/bash

# Create a directory for the model
mkdir -p open_llama_3b_v2_easylm
cd open_llama_3b_v2_easylm

# Download the EasyLM format model file
wget https://huggingface.co/openlm-research/open_llama_3b_v2_easylm/resolve/main/open_llama_3b_v2_easylm

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Download complete!"
    
    # Move the file to your GCS bucket (move instead of copy)
    gsutil mv open_llama_3b_v2_easylm gs://jsg-bucket/open_llama_3b_v2_easylm/
    
    # Check if the move was successful
    if [ $? -eq 0 ]; then
        echo "Move to GCS complete! File removed from local VM."
    else
        echo "Failed to move to GCS."
    fi
else
    echo "Download failed."
fi