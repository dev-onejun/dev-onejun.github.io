---
layout: post
title: "[Lecture] KIAS Lecture Series on Computational Neuroscience and AI"
subtitle: "Korea Institute for Advanced Study (KIAS) hosted a lecture series from August 4 to 6, 2025."
categories: [Review/Event]
tags: [Conference, IJCAI2025]
comments: true
---

Attended the lectures at August 4 and 5, 2025.

http://events.kias.re.kr/h/CNAI2025/?pageNo=5989

Below is the raw notes I took during the lectures.

## A Multi-Scale Framework for Understanding Biological and Artificial Neural Networks

**Speaker**: Dr. SueYeong Chung (Harvard University / Flatiron Institute)\
**Date**: August 4, 2025

```
* feature maps로 부터 linear regresssion 돌려서 정확도를 측정?
    - 수학적인 영역이라는데. 아직까지 linear regression보다 좋은 방법이 있는지 활발하게 논의 중이라고 함.
    - can we apply this into audio feature maps? to find phonemes?



---

1. dimensional
2. radius
3. center corr.
4. Axes corr.

** Theory of neural manifolds **

의의: dimension을 줄이지 않고도 데이터 분포를 측정할 수 있다.

cf.
최근 large scale image 모델들이 neural data representation과 simlarity 보이기 시작했다
Schrimpf et al., 2018 / ?

* Self-supervised learning of Maximum Manifold Capacity Representation (Yerxa, Kuang, Simoncelli, Chung, NeuRIPS(2023, 2024)

--
* random initialize하고, manifolds를 잘 나눠주는 모델을 찾아 이 weights와,
train하고 나서의 weights로 비교해서
학습 후 정말 feautre를 잘 학습했는지 확인할 수 있다.

--
Multitask generalization with shared latent structure

Manifold represntations & capacity for continuous tasks
- "Statistical MEchanics of ?"
```

### References

- Center For Brains Minds + Machines, James DiCarlo, https://cbmm.mit.edu/about/people/dicarlo
- Google Search, "linear regression from a neural feature matrix"
- Google Search, "theory of neural manifolds"
- Google Search, "low dimensional assumption"

+ Francesca Mignacco, et al., 2025, "Nonlinear classification of neural manifolds with contextual information", arXiv
+ Abdulkadir Cantar, et al., 2023, "A Spectral Theory of Neural Prediction and Alignment", NeurIPS
+ SueYeon Chung, et al., 2018, "Classification and Geometry of General Perceptual Manifolds", American Physical Society
+ SueYeon Chung et al., 2021, "Neural population geometry: An approach for understanding biological and artificial neural networks", Current Opinion in Neurobiology
+ Uri Cohen, et al., 2020, "Separability and geometry of object manifolds in deep neural networks", Nature Communications

## Predictive coding in cortical microcircuits

**Speaker**: Dr. Hannah Choi (School of Mathematics, Georgia Institute of Technology)\
**Date**: August 5, 2025

```
# Predictive Coding

ANN \
m biological neural networks (lack) -> energy efficient, adaptable, and robust computations of 'preedictions' and 'novelty'

* Context에서 벗어나는 novelty or unexpected sensory input gets an "attention" and enhances "learning and memorA"y

** 일상 이미지에대해 internal model (expectation)이 있을텐데, 무언가 바뀌면, predictive error가 발생해서 이 signal을 통해 internal model을 activated neuron을 적게 하는 쪽으로 업데이트한다**

    - 'Feedback signals' carry 'predictions' from the lower area aacitivities into higher hierarchical areas in the brain

1. Sparse Coding achives eneregy efficiency (Olshausen & Field 1996, 1997. Nature, Vision Research)
    - the number of activated neurons is tended to be small.

2. Hierarchical predictive coding (Rao & Ballard, 1999, nature.) (1 진화)
3. Maximum a posteriori (MAP) inference (Rao & Ballard, 1999, Nature)
    - hierarchy에 대해 일반화한 식
    - 이걸 gaussian distribution을 따른다고 가정하면, - log cost function으로 정리할 수 있다.
    - g(r)을 통해 activated neuron 수를 최소화 한다.

-- Recent works
Hypothesis 1: pablo picasso 보다 일반적인 그림들, 사실주의 그림들의 세상에 살아 그 마스크를 그에 맞게 예측할 것

* Choi, Pasupathy, Shea-Brown (2017, 2018 (neural computation))
- V4에서 neuron의 activation이 familar하지 않은 도형에서 familar에 가까워질수록 (firing rate)이 낮아졌다

---
when it comes to our perception, we use body movement like eye movement, active touching, sniffing, etc.
    ex. eye movement, 머리 움직이는 거 등: 'active vision'

* PRedictive coding in active vision for hidden images (Sharafeldin, Imam, Choi. 2024. Patterns)

---
**recnet ineterest)**
1. 현재의 ANN은 뇌의 hierarchy를 내포하지 않는다.
    - Layer-specific connectivity across the cortical hierarchy
2.
    - Diverse cell types and connectivity in cortical circuits.

* Wryick, Cain, LArsen, ..., Choi, Garrett, Mazzucato (2023, biorxiv)
    - abcd, abcx, abcd ... sequence를 주어줬을 때
        x의 예측이 D의 위치와 corresponding 하는 경향이 보인다
        뇌의 higher cortex 에서. lower에서는 구분.
    - 뇌의 hierarchy에 따라 역할이 다르다

* CorticalRNN (Balwani, Cho, Choi. 2025. Neural Computation)

---
* Neuroanatomical implementation of predective coding
    - 2012 paper. Two different neurons for positive and negative prediction errors in a model
    - Hertag, Wilmes & Clopath. 2024. Nature Communications

1. absolute novelty
2. contextual novelty
3. omission novelty
    - due to the non-existence even though it was expected

### Random Thoughts

* *predictive coding frameowrk로 groudn truth가 없는 데이터들에 대해서 할 수 있지 않을까?*.
```

### References

- Aishwarya Balwani, et al., 2025, "Exploring the Architectural Biases of the Cortical Microcircuit", Neural Computation
