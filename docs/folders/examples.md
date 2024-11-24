# Examples Directory Documentation

## Overview
The `examples/` directory contains ready-to-use scripts demonstrating various functionalities of EasyLM, particularly focused on training and serving large language models.

## Directory Contents

```
examples/
├── pretrain_llama_7b.sh
├── serve_llama_7b.sh
├── train_openllama_3b.sh
├── train_openllama_3b_modified.sh
├── train_openllama_3b-withq.sh
└── train_openllama_3b-withoutq.sh
```

## Script Categories

### Pre-training Scripts
1. `pretrain_llama_7b.sh`
   - Full pre-training configuration for LLaMA 7B model
   - Includes data pipeline setup and hyperparameter settings
   - Designed for large-scale training on TPU/GPU clusters

### Serving Scripts
1. `serve_llama_7b.sh`
   - Production-ready serving configuration
   - Includes API endpoint setup and resource management
   - Supports batch inference and request handling

### Training Variants
1. `train_openllama_3b.sh`
   - Base configuration for OpenLLaMA 3B model
   - Standard training setup with default parameters
   - Suitable for most use cases

2. `train_openllama_3b_modified.sh`
   - Modified training configuration
   - Contains customized hyperparameters
   - Optimized for specific use cases

3. `train_openllama_3b-withq.sh`
   - Quantization-aware training
   - Memory-optimized configuration
   - Suitable for resource-constrained environments

4. `train_openllama_3b-withoutq.sh`
   - Full precision training
   - Maximum accuracy configuration
   - Requires more computational resources

## Common Parameters

### Training Parameters
```bash
# Learning rate configuration
--learning_rate=1e-4
--warmup_steps=2000
--lr_decay_steps=500000

# Batch size and gradient accumulation
--batch_size=32
--gradient_accumulation_steps=8

# Model configuration
--model_size="3B"
--hidden_size=2048
--num_attention_heads=16
```

### Data Configuration
```bash
# Data paths
--train_data_path="/path/to/training/data"
--eval_data_path="/path/to/validation/data"

# Data processing
--max_sequence_length=2048
--vocab_size=32000
```

### Hardware Configuration
```bash
# Device configuration
--mesh_shape="1,4,2"
--num_partitions=8

# Memory management
--gradient_checkpointing=true
--dtype="bfloat16"
```

## Usage Guidelines

### Basic Usage

1. Pre-training:
```bash
bash examples/pretrain_llama_7b.sh
```

2. Serving:
```bash
bash examples/serve_llama_7b.sh
```

3. Training OpenLLaMA:
```bash
# Standard training
bash examples/train_openllama_3b.sh

# With quantization
bash examples/train_openllama_3b-withq.sh
```

### Customization

1. Modifying Training Parameters
```bash
# Edit the script and adjust parameters
vim examples/train_openllama_3b.sh

# Common modifications:
--learning_rate=2e-4  # Adjust learning rate
--batch_size=64      # Change batch size
--model_size="7B"    # Change model size
```

2. Data Configuration
```bash
# Update data paths
--train_data_path="custom_data.json"
--eval_data_path="custom_eval.json"

# Adjust data processing
--max_sequence_length=4096
--preprocessing_num_workers=8
```

3. Hardware Setup
```bash
# TPU configuration
--mesh_shape="2,4,1"
--num_partitions=8

# GPU configuration
--device="gpu"
--num_gpus=8
```

## Best Practices

### Training
1. Resource Management
   - Monitor memory usage
   - Adjust batch sizes based on available resources
   - Use gradient checkpointing for large models

2. Data Handling
   - Verify data paths and formats
   - Monitor data loading performance
   - Implement proper data validation

3. Model Configuration
   - Start with recommended hyperparameters
   - Adjust based on monitoring metrics
   - Save checkpoints frequently

### Serving
1. Performance
   - Configure appropriate batch sizes
   - Monitor response times
   - Implement request queuing

2. Resource Allocation
   - Set memory limits
   - Configure CPU/GPU utilization
   - Implement proper cleanup

3. Monitoring
   - Track inference metrics
   - Monitor system resources
   - Implement logging

## Troubleshooting

### Common Issues
1. Memory Errors
   - Reduce batch size
   - Enable gradient checkpointing
   - Use model parallelism

2. Training Instability
   - Adjust learning rate
   - Modify warmup steps
   - Check gradient clipping

3. Performance Issues
   - Monitor throughput
   - Optimize data loading
   - Check device utilization

### Solutions
1. Memory Management
```bash
# Enable memory optimization
--gradient_checkpointing=true
--optimize_memory=true
```

2. Training Stability
```bash
# Adjust training parameters
--learning_rate=5e-5
--warmup_steps=4000
--max_gradient_norm=1.0
```

3. Performance Optimization
```bash
# Optimize data loading
--preprocessing_num_workers=16
--prefetch_size=2
```

## Integration Examples

### WandB Integration
```bash
# Enable WandB logging
export WANDB_API_KEY="your-key"
export WANDB_PROJECT="llm-training"
```

### Custom Metrics
```bash
# Add custom evaluation
--eval_steps=1000
--eval_metrics="perplexity,accuracy"
```

### Checkpoint Management
```bash
# Configure checkpointing
--save_checkpoint_freq=1000
--max_checkpoints=5
