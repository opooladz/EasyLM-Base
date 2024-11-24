# EasyLM Folder Structure Documentation

This document provides a comprehensive overview of each main folder in the EasyLM repository.

## Directory Structure Overview

```
EasyLM/
├── docs/         - Project documentation
├── EasyLM/       - Main package source code
├── examples/     - Example scripts for training and serving
└── scripts/      - System setup and utility scripts
```

## Detailed Folder Documentation

### docs/
The documentation folder contains detailed information about various aspects of the project:
- `checkpointing.md` - Documentation for model checkpointing functionality
- `dataset.md` - Information about dataset handling and processing
- `evaluation.md` - Model evaluation procedures and metrics
- `koala.md` - Documentation for the Koala chatbot model
- `llama.md` - Documentation for LLaMA model implementation
- `logger.md` - Logging system documentation
- `optimizer.md` - Information about supported optimizers
- `parallelism.md` - Details about model parallelism implementation
- `serving.md` - Model serving and deployment documentation

### EasyLM/
The main package directory containing the core implementation:

#### Core Modules:
- `__init__.py` - Package initialization
- `bpt.py` - Brain Preferred Transformer implementation
- `checkpoint.py` - Model checkpointing utilities
- `data.py` - Dataset handling and processing
- `jax_utils.py` - JAX-specific utility functions
- `optimizers.py` - Optimization algorithms
- `serving.py` - Model serving infrastructure

#### Subdirectories:
1. `models/` - Model implementations
   - `llama/` - LLaMA model implementation including training, serving, and conversion utilities
   
2. `scripts/` - Utility scripts for:
   - Attention benchmarking
   - Checkpoint conversion and comparison
   - Language model evaluation

### examples/
Contains example scripts demonstrating how to use EasyLM:
- Pre-training scripts for LLaMA models
- Model serving examples
- Training scripts for OpenLLaMA in various configurations

### scripts/
System administration and setup scripts:
- TPU-related utilities:
  - `delete_tpu_lockfile.sh` - Cleanup script for TPU locks
  - `free_tpus.sh` - Script to free TPU resources
  - `tpu_commands.sh` - Common TPU management commands
  - `tpu_vm_setup.sh` - TPU virtual machine setup script

- Environment setup:
  - `gpu_environment.yml` - Conda environment specification for GPU setup
  - `vm_setup_plain.sh` - Basic virtual machine setup script

- Storage and data management:
  - `get_weights.sh` - Script to download model weights
  - `mount_bucket.sh` - Cloud storage bucket mounting utility
  - `install_fuse.sh` - FUSE filesystem installation script

## Usage Patterns

1. For new users:
   - Start with the `examples/` directory to understand basic usage
   - Reference `docs/` for detailed feature documentation

2. For development:
   - Core implementations are in the `EasyLM/` directory
   - Use `scripts/` for environment setup and system management

3. For deployment:
   - Refer to `docs/serving.md` for deployment guidelines
   - Use example serving scripts in `examples/` as templates

## Best Practices

1. Model Training:
   - Use scripts in `examples/` as templates for your training runs
   - Follow checkpointing guidelines in `docs/checkpointing.md`

2. Development:
   - Follow the existing code structure in `EasyLM/`
   - Ensure new models are implemented under `EasyLM/models/`

3. System Setup:
   - Use appropriate setup scripts from `scripts/` based on your infrastructure
   - Follow TPU-specific guidelines for cloud deployments
