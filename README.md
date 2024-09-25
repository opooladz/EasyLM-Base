# How to use google cli with this repo...

Make a tmux on ur local and follow the following

bash tpu_vm_setup_plain.sh

```bash
 gcloud compute tpus tpu-vm ssh SERVER_NAME --zone us-central2-b --worker=all --project  PROJECT_NAME --command 'cd EasyLM-Base && bash scripts/vm_setup_plain.sh
```

How to Free TPUs of stale tasks. do this after killing runs.  generally u shouldnt delete server. this just frees the pids....

```bash
bash scripts/free_tpus.sh --project  PROJECT_NAME --zone us-central2-b --tpu_name SERVER_NAME
```


How to pull ur updates. 

```bash
gcloud compute tpus tpu-vm ssh SEVER_NAME --zone us-central2-b --worker=all --project PROJECT_NAME --command 'cd EasyLM-Base && git  pull https://GITHUB_KEY@github.com/opooladz/EasyLM-Base.git'
```

How to start a run.

```bash
 gcloud compute tpus tpu-vm ssh SERVER_NAME --zone us-central2-b --worker=all --project  PROJECT_NAME --command 'export WANDB_API_KEY=YOUR_KEY && cd EasyLM-Base && nohup bash ./examples/whatever_u_wanna_run.sh  > nohup.out 2>&1 &'
```


To see the progress of ur run -- mostly for debugging make a new window in tmux cntrl + b : split -h <-- if you dont know tmux learn it. 

```bash
gcloud compute tpus tpu-vm ssh SERVER_NAME --zone us-central2-b --worker=0 --project PROJECT_NAME --command 'tail -f EasyLM-Base/nohup.out'
```




# EasyLM
Large language models (LLMs) made easy, EasyLM is a one stop solution for
pre-training, finetuning, evaluating and serving LLMs in JAX/Flax. EasyLM can
scale up LLM training to hundreds of TPU/GPU accelerators by leveraging
JAX's pjit functionality.


Building on top of Hugginface's [transformers](https://huggingface.co/docs/transformers/main/en/index)
and [datasets](https://huggingface.co/docs/datasets/index), this repo provides
an easy to use and easy to customize codebase for training large language models
without the complexity in many other frameworks.


EasyLM is built with JAX/Flax. By leveraging JAX's pjit utility, EasyLM is able
to train large models that don't fit on a single accelerator by sharding
the model weights and training data across multiple accelerators. Currently,
EasyLM supports multiple TPU/GPU training in a single host as well as multi-host
training on Google Cloud TPU Pods.

Currently, the following models are supported:
* [LLaMA](https://arxiv.org/abs/2302.13971)
* [LLaMA 2](https://arxiv.org/abs/2307.09288)
* [LLaMA 3](https://llama.meta.com/llama3/)

## Discord Server
We are running an unofficial Discord community (unaffiliated with Google) for discussion related to training LLMs in JAX. [Follow this link to join the Discord server](https://discord.gg/Rf4drG3Bhp). We have dedicated channels for several JAX based LLM frameworks, include EasyLM, [JaxSeq](https://github.com/Sea-Snell/JAXSeq), [Alpa](https://github.com/alpa-projects/alpa) and [Levanter](https://github.com/stanford-crfm/levanter).


## Models Trained with EasyLM
### OpenLLaMA
OpenLLaMA is our permissively licensed reproduction of LLaMA which can be used
for commercial purposes. Check out the [project main page here](https://github.com/openlm-research/open_llama).
The OpenLLaMA can serve as drop in replacement for the LLaMA weights in EasyLM.
Please refer to the [LLaMA documentation](docs/llama.md) for more details.


### Koala
Koala is our new chatbot fine-tuned on top of LLaMA. If you are interested in
our Koala chatbot, you can check out the [blogpost](https://bair.berkeley.edu/blog/2023/04/03/koala/)
and [documentation for running it locally](docs/koala.md).


## Installation
The installation method differs between GPU hosts and Cloud TPU hosts. The first
step is to pull from GitHub.

``` shell
git clone https://github.com/young-geng/EasyLM.git
cd EasyLM
export PYTHONPATH="${PWD}:$PYTHONPATH"
```

#### Installing on GPU Host
The GPU environment can be installed via [Anaconda](https://www.anaconda.com/products/distribution).

``` shell
conda env create -f scripts/gpu_environment.yml
conda activate EasyLM
```

#### Installing on Cloud TPU Host
The TPU host VM comes with Python and PIP pre-installed. Simply run the following
script to set up the TPU host.

``` shell
./scripts/tpu_vm_setup.sh
```


## [Documentations](docs/README.md)
The EasyLM documentations can be found in the [docs](docs/) directory.


## Reference
If you found EasyLM useful in your research or applications, please cite using the following BibTeX:
```
@software{geng2023easylm,
  author = {Geng, Xinyang},
  title = {EasyLM: A Simple And Scalable Training Framework for Large Language Models},
  month = March,
  year = 2023,
  url = {https://github.com/young-geng/EasyLM}
}
```



## Credits
* The LLaMA implementation is from [JAX_llama](https://github.com/Sea-Snell/JAX_llama)
* The JAX/Flax GPT-J and RoBERTa implementation are from [transformers](https://huggingface.co/docs/transformers/main/en/index)
* Most of the JAX utilities are from [mlxu](https://github.com/young-geng/mlxu)
* The codebase is heavily inspired by [JAXSeq](https://github.com/Sea-Snell/JAXSeq)
