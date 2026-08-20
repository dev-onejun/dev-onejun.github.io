$$
\begin{array}{|c|c|}
\hline
\text{} & \text{} \\
\hline
\text{} & \text{} \\
\hline
\end{array}
$$

# AI Optimization Lecture 3: Distillation, Pruning, and Quantization

https://www.youtube.com/watch?v=Krcp51UQjbI&list=PLuOtX1AplgcvdjCK-tk4TPiYOGsKkil6J&index=3

Compacting the model

P. Agent has too much outdated knowledge (info)

## Distillation

How to teach generalziatoin ability: Hard target (one-hot) -> Soft target (Softmax)
    - This is a distilation idea to get a smaller model

From the hard-target of big model, distilation to small model with soft-target.

## Pruning

Despite the fact above in distillation, if we start with a small model from the start,
slower to train and worse accuracy.
    - Not all weights are equally important

1) Structured pruning: set some weights to zero, but keep the structure of the model (e.g., set a near zero weight to zero, but keep the structure of the model - Magnitude pruning)
2) Unstructured pruning: cut away some branches entirely.
    - Depth-based pruning: cut an entire layer
        - faster inference, but worse accuracy
    - Width-based pruning: cut neurons across layers, following the path
        - better accuracy, but slower inference

    + Magnitude pruning
    + Activation-based Pruning: Uses a calibration dataset to estimate the importance of different parts of the model based on their activations. More accurate. (AWQ?)
        - importance is calculated by $logits(original) - logits(pruned)$: if the difference is bigger, then the weight is more important and don't prune it. If the difference is smaller, then the weight is less important and can be pruned.

## Quantization

In FP8, 70B model needs 70GB gpu memory. # Billion parameters = # GB gpu memory

- Improved speed, but reduced accuracy (quality)

## Interview questions

1) Between pruning and quantization, which one to choose?
    - if you have a gpu to run a bigger model, you can try activation-based pruning first.
    - but usually we don't have a large-memory gpu, so we usually choose quantization first

    + But which one gives better accuracy?

* Another attempt: Keep some weights in full-precision while quantizing the less important weights to lower precision - **Mix precision**
    - P: slow. since gpu is optimized for one precision, so mixing precision will slow down the inference speed.

* Another attempt: Activation-aware Quantization (AWQ)
    - Quantized all weights, but multiply the important weights by 2?
    - 다른 수가 아ㅣㄴ고 2 인 이유는 실험적으로 2가 가장 좋았기 때문

2) how to compute dynamic range?. how to choose the proper quantization range. per layer? per tensor? or per channel?
    - try to think

## Wrap-up

Quantization is easily compounded to distillation and pruning.

### References

$\tag*{}\label{n} \text{[n] }$
