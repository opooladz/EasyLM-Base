# Scripts Directory Documentation

## Overview
The `scripts/` directory contains essential system administration, setup, and utility scripts for managing TPU/GPU environments, cloud storage, and development setup.

## Directory Contents

```
scripts/
├── delete_tpu_lockfile.sh
├── free_tpus.sh
├── get_weights.sh
├── gpu_environment.yml
├── install_fuse.sh
├── mount_bucket.sh
├── tpu_commands.sh
├── tpu_vm_setup.sh
└── vm_setup_plain.sh
```

## Script Categories

### TPU Management Scripts

1. `delete_tpu_lockfile.sh`
   - Purpose: Removes TPU lock files
   - Use case: Cleaning up after crashed jobs
   - Usage: `bash scripts/delete_tpu_lockfile.sh`

2. `free_tpus.sh`
   - Purpose: Releases TPU resources
   - Use case: Cleanup after training
   - Usage: `bash scripts/free_tpus.sh --project PROJECT_NAME --zone ZONE --tpu_name TPU_NAME`

3. `tpu_commands.sh`
   - Purpose: Common TPU management commands
   - Use case: TPU administration
   - Contains: Setup, monitoring, and maintenance commands

4. `tpu_vm_setup.sh`
   - Purpose: TPU VM environment setup
   - Use case: Initial TPU configuration
   - Sets up: Python environment, dependencies, and configurations

### Environment Setup Scripts

1. `gpu_environment.yml`
   - Purpose: Conda environment specification
   - Use case: GPU development setup
   - Contains: Package dependencies and versions

2. `vm_setup_plain.sh`
   - Purpose: Basic VM configuration
   - Use case: General development environment setup
   - Sets up: Basic development tools and dependencies

### Storage Management Scripts

1. `get_weights.sh`
   - Purpose: Downloads model weights
   - Use case: Model initialization
   - Usage: `bash scripts/get_weights.sh MODEL_NAME`

2. `install_fuse.sh`
   - Purpose: FUSE filesystem setup
   - Use case: Cloud storage mounting
   - Sets up: FUSE dependencies and configurations

3. `mount_bucket.sh`
   - Purpose: Cloud storage bucket mounting
   - Use case: Data access
   - Usage: `bash scripts/mount_bucket.sh BUCKET_NAME MOUNT_POINT`

## Usage Guidelines

### TPU Setup and Management

1. Initial TPU Setup
```bash
# Set up TPU VM environment
gcloud compute tpus tpu-vm ssh TPU_NAME --zone ZONE --worker=all \
    --project PROJECT_NAME --command 'cd EasyLM-Base && bash scripts/tpu_vm_setup.sh'
```

2. Resource Management
```bash
# Free TPU resources
bash scripts/free_tpus.sh \
    --project PROJECT_NAME \
    --zone ZONE \
    --tpu_name TPU_NAME

# Delete TPU lock files
bash scripts/delete_tpu_lockfile.sh
```

### GPU Environment Setup

1. Creating Conda Environment
```bash
# Create environment from specification
conda env create -f scripts/gpu_environment.yml

# Activate environment
conda activate EasyLM
```

2. Environment Verification
```bash
# Verify CUDA availability
python -c "import torch; print(torch.cuda.is_available())"
```

### Storage Management

1. Cloud Storage Setup
```bash
# Install FUSE
bash scripts/install_fuse.sh

# Mount storage bucket
bash scripts/mount_bucket.sh my-bucket /mnt/bucket
```

2. Model Weight Management
```bash
# Download model weights
bash scripts/get_weights.sh llama-7b
```

## Best Practices

### TPU Management

1. Resource Cleanup
   - Always free TPU resources after use
   - Clean up lock files when jobs crash
   - Monitor resource usage

2. Environment Setup
   - Follow setup script order
   - Verify installations
   - Test configurations

### Development Environment

1. GPU Setup
   - Use provided conda environment
   - Test CUDA availability
   - Monitor GPU memory

2. VM Configuration
   - Follow security best practices
   - Configure resource limits
   - Set up monitoring

### Storage Management

1. Data Access
   - Use appropriate mount points
   - Monitor storage usage
   - Implement backup strategies

2. Weight Management
   - Verify downloads
   - Track versions
   - Manage storage space

## Troubleshooting

### Common Issues

1. TPU Problems
   - Lock file issues
   - Resource allocation failures
   - Connection problems

2. Environment Issues
   - Package conflicts
   - CUDA compatibility
   - Memory limitations

3. Storage Issues
   - Mount failures
   - Permission problems
   - Space constraints

### Solutions

1. TPU Fixes
```bash
# Clean up TPU resources
bash scripts/free_tpus.sh --project PROJECT_NAME --zone ZONE --tpu_name TPU_NAME
bash scripts/delete_tpu_lockfile.sh

# Verify TPU status
gcloud compute tpus tpu-vm describe TPU_NAME --zone ZONE
```

2. Environment Fixes
```bash
# Recreate environment
conda env remove -n EasyLM
conda env create -f scripts/gpu_environment.yml

# Verify installation
python -c "import jax; print(jax.devices())"
```

3. Storage Fixes
```bash
# Remount storage
bash scripts/mount_bucket.sh BUCKET_NAME MOUNT_POINT --force

# Check permissions
ls -la /mnt/bucket
```

## Security Considerations

### Access Control
- Use appropriate permissions
- Implement authentication
- Monitor access logs

### Data Protection
- Encrypt sensitive data
- Implement backup strategies
- Monitor storage usage

### System Security
- Keep systems updated
- Follow security best practices
- Monitor system logs

## Performance Optimization

### Resource Management
- Monitor resource usage
- Optimize configurations
- Implement cleanup routines

### Storage Access
- Optimize mount configurations
- Monitor I/O performance
- Implement caching strategies

### Environment Setup
- Optimize package versions
- Configure resource limits
- Monitor performance metrics
