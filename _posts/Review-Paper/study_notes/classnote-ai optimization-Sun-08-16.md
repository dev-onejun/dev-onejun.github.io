$$
\begin{array}{|c|c|}
\hline
\text{} & \text{} \\
\hline
\text{} & \text{} \\
\hline
\end{array}
$$

# AI Optimization Lecture 4: Grouped Query Attention, Paged Attention, Flash Attention

https://www.youtube.com/watch?v=Myhz-whrq5Q&list=PLuOtX1AplgcvdjCK-tk4TPiYOGsKkil6J&index=2

1) Multi-haead attention
2) Multi-query attention
3) Group Query Attention
4) Flash Attention
5) Paged Attention

1,2,3 are math-based optimization, 4,5 are engineering-based optimization.

## Multi-head attention

P. (1-head) Attention has an issue that each feature (e.g. noun, verb, preposition) gets mixed up to the one-dimensional attention vector.

Deriving a multi-filter and concat idea from Convolution, project the input (query and key) into multiple subspaces.

=> Gives both more good quality and faster training speed.

## Multi Query Attention

P. Multi-head attention has a single query but multiple keys and values so that it needs more memory

Reduce multiple keys and values to a single key and value, while keeping multiple queries.
Since each query has its own question (e.g. what is 'noun' score, what is 'verb' score, what is 'preposition' score), we can use a single key and value to answer all queries.

* Interview question: Does multi-query save memory and compute?

- save memory but not compute (compute is same)

=> Reduced memory usage and little bit faster training speed.

## Grouped Query Attention

P. Multi-query attention: the quality becomes worse (WHICH IS OBVIOUS I THINK) and training unstable.

Rather than multi-head or multi-query (all individual KV or one KV), 중간 숫자의 head 사용, query를 그룹으로 묶어서 KV 공유 계산. (A MIDDLE POINT BETWEEN MULTI-HEAD AND MULTI-QUERY)

=> Balanced quality and speed.

* Interview question: Does grouped query save memory and compute?
    - save memory but same compute (than multi-head attention.)
* Is group query attention for prefill or decode?
    - it's basically for memory saving so that it's for decode

## Paged Attention

* KV Cache: Every past context is stored via Key and Value

Naive -> Blocks -> Pages processing for KV cache. (how they are evolved)

## Flash Attention

P. still requires to pull the entire n^2 attention matrix

In a decode stage, Paged attention requires to pull the entire n^2 attention matrix to calculate the last query's attention score, which is inefficient.
so, Flash attention tries to calculate the last query's attention score chunk by chunk, which was originiated from (the already pulled KV cache?)
    - using **blockwise attention and online attention**
    - **incrementally rescaling the attention score in each chunk step to correct it to the exact final attention score.**

=> 1) such small chunk (block) size is fit at GPU SRAM, which makes the calculation faster.
2) less memory usage
(SO BASICALLY, IT ACHIVES BOTH SPEED AND MEMORY)

FEEL LIKE THE CONTENTS OF PAGED AND FLASH ARE MIXED NOW. NEED TO CHECK

# Lecture 5: Continuous Batching, Inflight Batching

* Inference serving system: ex. vLLM is a serving system and pytorch is execution engine

when multiple users send requests simultaneously to the inference server, a scheduler at the server groups the requests into a batch and sends it to the execution engine.
    - to increase gpu utilization (parallelize the matrix calculation)

P1. static batching: Once the batch is formed, it is fixed and cannot be changed so that users might wait for a long time until the previous batch is finished. (cannot early return and cannot inject new requests during the execution of the batch)

S1. Continuous batching (Orca, 2022): If one of the requests in the batch gives <EOS> (the end of sentence) token, that request is returned to the user immediately, while the another request replaces the returned request in the batch without stopping the batch processing.

P2. The new request (replacement) needs different operations (prefill, while others highly likely need decode). Even the length of the new request is different from the others, it needs to be processed in the same batch (The length difference problem)

S2. Selective batching (Orca, ?): concat and flatten the requests in the batch while sitll calculating the attention score per request and merge at the end. (kind a multi-head attention but with different length of queries)

P3. multiple attention matrices might be too costly.

S3. Piggy back decoding (Decode-maximal batching. 2023): ?
    - Only needs two attention matrices (one for prefill and one for decode)


### References

$\tag*{}\label{n} \text{[n] }$
