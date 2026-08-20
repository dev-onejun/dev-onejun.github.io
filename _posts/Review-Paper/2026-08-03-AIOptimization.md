---
layout: post
title: "[Review] Performance Optimization for AI"
subtitle: "[Working title] Parallel Computing and Performance Optimization 101"
categories: [Review/Paper]
tags: [Review, Parallel Computing, Performance Optimization, AI]
comments: true
---

This note is to review an AI optmization specifically in a low-level to prepare an interview.
<!--This article is to review an AI optmization specifically in a low-level to prepare an interview.-->

<!--*An initial thought was to wrap-up and write an 101 of the optimization. But unfortunately, after skimming the content, I realized that it might be hard to contain all those stuffs at once. Therefore, this article focuses on the low-level part of the optimization for the upcoming interview. (The rest of them will be updated based on my availability)*-->

## Preill and Decode

* Prefill: compute-bound
* Decode: memory-bound

## Parallelism

* Tensor Parallelism (TP)
    - split a model into multiple gpus
* Data Parallelism (DP)
    - multiple models, forwarding a data in parallel
    - ex. K and V are duplicated across gpus
    - However, **ZeRo-DP** (Zero Redundancy Optimizer for Data Parallelism) is a memory-saving technology, comprising of three stages (optimizer, gradient, and parameter partitioning)
        - https://share.google/aimode/Z8PucMgRKs879XQQA
        - Due to this (communication bottleneck derived by TP), DeepSeek also adopted EP and ZeRo-DP without TP.
* Pipeline Parallelism
* Expert Parallelism (EP)
    - Sparse Attention (MoE)

***TP 3 and DP 2*** means it will provide an inference system within three gpus for each model and two models simultaneously. Therefore, six gpus are required.

cf. In FP8, 70B models = 70 GB GPU memory

# AI Optimization 1: Low-level

## Distillation, pruning and quantization

* Distillation
* Pruning (might cut a wrong, duplicated, or outdated knowledge)
    - Structured pruning
        - Magnitude pruning
        - Activation-based pruning
    - Unstructured pruning
        - Dept-based pruning
        - Width-based pruning
* Quantization
    - Use both pruning and distillation in a quantization setting. It will make more efficient
    - Mix precision -> Activation-aware Quantization (AWQ)
    - Dynamic range options
        - Per-tensor (layer): good for hardware efficiency, but subject to outliers
        - Per-channel: good for quality, but hardware burden

## Kernel

* T=N; T>N; T<N; and Grid-stride loop
* cudaMallocManaged, cudaMemcpy, cudaMemcpyHostToDevice, cudaMemcpyDeviceToHost
* cudaStream
* someKernel<<<blocks, threads, sharedMemSize(0), stream>>>
    - overlapping data transfer and kernel execution
* Map, reduction, scan/prefix, and sort

# AI Optimization 2

## Attention families

Self-attention

### Architecture-level

* Multi-head attention
* Multi-query attention
    - saves memory, same compute, less quality
* Grouped-query attention
    - saves memory, same compute (comparing with multi-head)
    - the middle point

![Attentions](/assets/img/review/ai_optimization/attentions.png)

### Math-based

* Paged attention
    - naive -> block -> paged
* Flash attention
    - chain rule

<!--
***Abstract***\
Within last couple of years, a scaling law has been still validated for AI models, inherently occupying an Attention mechanism. On top of the shortage of computing resources, the performance optimization leads to not only a better utilization of the hardware but also a better performance of the model. Such circumstances drives a temporal but drastic force, giving a computer scientist an opportunity to get in the major issue. This article reviews "parallel computing and performance optimization for AI" to understand the fundamentals of them and facilitate to practical usages. xxx.

* Kernel
    - **flash attention: rewrites the attention more memory-efficient**
* **Quantization**
    - FP16, BF16, FP8,
    - Activation-aware Weight Quantization (AWQ), or Generalized Post-Training Quantization (GPTQ)
    - GGUF (llama.cpp)
* Agent & RAG. Systematic
    - (Automatic) prefix caching
    - Disaggregated prefill and decode
        - long prompts to a prefill cluster
        - generation requests to a decode cluster
    - KV Cache Management
        - Paged attention
    - Speculative Decoding: ?

LLM Phases
1) Prefill: processing your prompt
    - expensive, compute-intensive (compute-bound), batch-friendly
    - prefix caching -> speeds up in TTFT
2) Decode: Generating tokens
    - 1 token at a time, memory-bound, latency-sensitive, small batches

Continuous batching?



From the Computer Science perspective, especially computer architecture and operating system,
combining ...
(ex. Intel x86 vs. ARM)

Such view leads to the performance optimization while operating AI in the recent technological waves.
I would divide into three areas:
1) Kernel, 2) Quantization, and 3) Systematic approaches.

This article mainly targets the low-level performance optimization and computer architectures for AI.
For example, parallelization for deep learning models is addressed.
Among the three areas that I suggested, the first and second topics are mainly reviewed.

### 1) Kernel

I would regard you that you already knew what Attention is.

flash attention
-->
