$$
\begin{array}{|c|c|}
\hline
\text{} & \text{} \\
\hline
\text{} & \text{} \\
\hline
\end{array}
$$

# How to write a CUDA program: The parallel programming edition

Stephen Jones, CUDA Architect, NVIDIA | GTC 2025 \
https://www.youtube.com/watch?v=GmNkYayuaA4

Parallel programming only needs at Kernel Authoring among the features that CUDA provides.
*Presenter recommended not to do parallel programming cuz CUDA basically gives you a lot of features that you don't need to use.*

CUDA Math Libraries (ex. cuBLAS, cuFFT, ...) are already and highly optimized the performance.

cf. H100 has 132 SMs where 2,048 threads are executed per SM. So, 132 * 2,048 = 270,336 threads can be executed in parallel.
    - 서버용 (A100, H100, ...)은 2,048 threads per SM, but
    - consumer (RTX 3090, ...) is 1,536 (or 1,024 for optimized) threads per SM. Spark도 동일.

if you multiply N to the data index $i$, then it means that you will process N data in a single thread.

```
__global__ void saxpy(float A, float *x, float *y, int N) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    if (i < N) {
        y[i] = A * x[i] + y[i];
    }
}
__global__ void saxpy4(float A, float *x, float *y, int N) {
    int i = (threadIdx.x + blockIdx.x * blockDim.x) * 4;
    if (i < N) {
        y[i] = A * x[i] + y[i];
        y[i + 1] = A * x[i + 1] + y[i + 1];
        y[i + 2] = A * x[i + 2] + y[i + 2];
        y[i + 3] = A * x[i + 3] + y[i + 3];
    }
}
```

In consequence, now you can process all data points at once within the SMs supported by the GPU (such circumstances depends on the GPU, cuz indeed, the number of SMs is different among GPUs).
*The number of threads per SM will be same (2048 threads per SM) to support the old code across gpu generations*
![SM and Max Threads per SM across Architecture](./Downloads/a.png)

=> This pattern is called 'grid-stride loop'

## Two types of parallelism

1) Task Parallelism

Divide independent programs across processors

**2) Data Parallelism**

Divide individual data elements across processors. **Divide and Conquer**

* Some fundamental parallel operators: ***1) Map, 2) Reduction, 3) Scan / Preix Sum, 4) Sort***

``` cuda
// Basic Parallel Reduction
__global__ void

// Advanced

// Ninja
```

So again, data parallelism (parallel programming) is very hard, and someone (nvidia) might be already highly optimized the performance already. You even can use it through not only CUDA C++ but also numba-cuda (python) or Warp?

### References

$\tag*{}\label{n} \text{[n] }$
