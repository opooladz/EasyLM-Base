#!/bin/bash

# Function to run a command on all TPU VMs and return its output
run_command() {
    output=$(gcloud compute tpus tpu-vm ssh LLaMA --zone us-central2-b --worker=all --command "$1" 2>&1)
    echo "$output"
}

# Function to run installation steps
install_gcsfuse() {
    # Set up the gcsfuse repository
    run_command "export GCSFUSE_REPO=gcsfuse-\$(lsb_release -c -s) && \
                 echo \"deb https://packages.cloud.google.com/apt \$GCSFUSE_REPO main\" | sudo tee /etc/apt/sources.list.d/gcsfuse.list"

    # Add the Google Cloud public key
    run_command "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -"

    # Update package list
    run_command "sudo apt-get update"

    # Install fuse and gcsfuse with automatic yes to prompts
    run_command "sudo apt-get install -y fuse gcsfuse"

    # Check gcsfuse version
    version_output=$(run_command "gcsfuse -v")
    echo "$version_output"
}

echo "Starting GCSFuse installation on all TPU VMs..."
install_output=$(install_gcsfuse)
echo "$install_output"

# Verify installation
verify_output=$(run_command "which gcsfuse && gcsfuse --version")
if echo "$verify_output" | grep -q "gcsfuse version"; then
    echo "GCSFuse successfully installed on all TPU VMs."
else
    echo "GCSFuse installation may have failed on some TPU VMs. Please check the output above for errors."
fi