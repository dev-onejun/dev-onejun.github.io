$$
\begin{array}{|c|c|}
\hline
\text{GGUF (GGML Unified Format)} & \text{GGML (GG Machine Learning)} \\
\hline
\text{} & \text{} \\
\hline
\end{array}
$$

# Llama.cpp

- a base of ollama, deepseek, qwen.
- creates models' GGUF files
    - provides a model compression with quantization
    - gives optimized kernels, supporting metal, CUDA, ROCm, Vulkan, cpu, etc.
        - custom CUDA kernels
- `llama-cli` and `llama-server`

# Mastering LLM Inference Optimization From Theory to Cost Effective Deployment: Mark Moyou

AI Engineer, Youtube, https://www.youtube.com/watch?v=9tvJ_GYJA-o, Accessed in Aug. 7th, 2026

* Understanding LLM Inference
    - Next token prediction (NTP)
    - Tokenizers
    - Caches (KV Cache)

* Size of model on GPU (GB) in FP16 = # Parameters * 2
    - ex. 8B model = 8B * 2 = 16GB

* Metrics for Inference performance measurement
    - Time to First Token (TTFT): how long ..
        - Measures the performance of the prefill stage and KV cache efficiency (TTFT = prefill time + kv cache time. TTFT of individual requests)
    - Inter-token Latency:
        - token-to-token latency
    - Time to Completion
    - Time to First Token vs. Number of Input tokens

* LLM Inference is different to other inference scenarios due to NTP

* Based on four different possible cases between input/output sequence lengths (ISL/OSL), statistical certainty for users' historical profile makes more optimized engines.

* Tensor RT
    - TensorRT Engine accelerates the Transformer Architecture
    - TensorRT-LLM handles the entire LLM

# AI Optimization - RedHat Blog

https://www.redhat.com/en/blog/ai-optimization-7-powerful-techniques-you-can-use-today

AI optimization cheat sheet

|Your pain point|Fix this first|This too!|
|---------------|--------------|---------|
|High latency|Prefix caching|Disaggregated prefill|
|Low throughput|Quantization|Continuous batching|
|OOM errors|KV cache management|Quantization|
|Long context(>8k)|Flash Attention|KV Cache Quantization|
|High $/token|Quantization|Speculative decoding|

?

# AI Optimization - NVIDIA Technical Blog

https://developer.nvidia.com/blog/top-5-ai-model-optimization-techniques-for-faster-smarter-inference/

1) Post-training quantization (PTQ)
2) Qauntization-aware training (QAT)
3) Quantization-aware distillation (QAD)
4) Speculative decoding
    - immediate generation speedups w/o retraining or quantization
    ![NVIDIA Blog. Figure 5.](https://developer-blogs.nvidia.com/wp-content/uploads/2025/12/speculative-decoding-draft-target-approach-1.gif)
5) Pruning and knowledge distillation

# AI Optimization Lecture, Faradawn Yang

## Prefill and Decode

https://www.youtube.com/watch?v=3SBUCJzogj4&list=PLwNAY4Y-B4ou-CwKnab0eFPXQmpgu_AdD&index=27

With a single node of GPU, LLM necessarily emerges a high-compute phase at the start, followed by a low-compute and memory-bound phase. The high-compute phase is called prefill, and the low-compute and memory-bound phase is called decode.

### Prefill

question prompt?
Takes a whole prompt and calculates the KV matrix for the entire prompt. Therefore, it requires a high compute. (needs verification)

### Decode

After all computes done, with the compressed metrix (maybe attention scores?),
it iteratively generates the next token repeatedly while accessing to the accumulated matrices,
which leads a low compute and memory-bound.

### nvidia solution?

dynamo - with a smart router, (in a cluster setting), divide the gpu clusters into prefill and decode clusters (ex. H100 and L40 clusters)

### Optimization vs. scalability

1) linear programming?

users allocation?

2) hyper parameter tuning?

## Three LLM Optimization

Parallelism - Tensor, Data, and Expert Parallelism

Due to the large size of LLM, it is necessary to split the model into multiple GPUs

Q1. Throughput vs. latency
Q2. Batch size small vs. large
Q3. Communication and bandwidth

## 1) Tensor Parallelism

one model cannot fit on one gpu. -> split the model into multiple GPUs.

Following a multi-head attention layer, the input is split into multiple GPUs, and each GPU computes a part of the output. The outputs are then concatenated to form the final output.

All reduce communication?

good for small batch size

limitation:

## 2) Data Parallelism

good for large batch size, but duplicate model weight

K and V are duplicated? so that it even saves the memory?

## 3) Expert Parallelism

for Feed Forward Network - Dense model needs too much compute. -> split the FFN into experts

Sparse Attention (Mixture of Experts) - bigger brain (parameters) but smaller activated experts (small experts and compute)

## Industry questions

### What is DP = 2, TP = 4. how many gpu needed?

DP = 2 -> 2 entire model
TP = 4 -> 4 GPUs for each model

=> if someone wants to run a model with DP=2 and TP=4, they would need a total of 8 GPUs. DP $\times$ TP = 2 $\times$ 4 = 8

### for TP env, should it be deployed into intra-node or inter-node?

cf. intra-node: multiple gpus in a single server, inter-node: multiple servers with multiple gpus

intra-node - usually use NV-link. bandwidth high, fast communication
inter-node -  Ethernet, Infiniband, etc. bandwidth low, slow communication

Intra-node is for tensor parallelism, Inter-node is for pipeline parallelism.

### What is Zero DP and FSDP (Fully shared data parallelism)?

Zero DP for inference, FSDP for training? (NEED TO CHeck)
those for training?

### What is challenges for EP?

Node imbalance. -> capacity?

## Why DeepSeek doesn't use Tensor Parallelism during training

it requires too many communication between GPUs, which can be a bottleneck and slow down the training process. Instead, DeepSeek uses data parallelism, which allows for more efficient training by distributing the data across multiple GPUs.

### References

$\tag*{}\label{1} \text{[1] IBM Technology, Youtube, "What Is Llama.cpp? The LLM Inference Engine for Local AI", https://www.youtube.com/watch?v=P8m5eHAyrFM, Accessed in Aug. 3rd, 2026}$
$\tag*{}\label{2} \text{[2] GGML-org, GitHub, "llama.cpp", https://github.com/ggml-org/llama.cpp, Accessed in Aug. 3rd, 2026}$
$\tag*{}\label{n} \text{[n] }$
