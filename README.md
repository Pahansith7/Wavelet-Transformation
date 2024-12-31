# Bio-signal Processing - Wavelet Analysis and Applications

This repository contains MATLAB scripts, analysis results, and documentation for various wavelet-based signal processing techniques, as part of **BM4152 Bio-signal Processing Assignment 3**.

---

## Table of Contents

1. [Overview](#overview)
2. [Continuous Wavelet Transform (CWT)](#continuous-wavelet-transform-cwt)
3. [Discrete Wavelet Transform (DWT)](#discrete-wavelet-transform-dwt)
4. [Signal Denoising with DWT](#signal-denoising-with-dwt)
5. [Signal Compression with DWT](#signal-compression-with-dwt)
6. [Repository Structure](#repository-structure)
7. [How to Use](#how-to-use)
8. [Results](#results)

---

## Overview

This project explores wavelet-based techniques for analyzing bio-signals, particularly ECG signals. Key objectives include:

- Understanding the theoretical basis of wavelet transforms.
- Implementing wavelet-based signal decomposition, denoising, and compression.
- Comparing wavelet types (e.g., Mexican Hat, Haar, and Db9) based on their performance.

---

## Continuous Wavelet Transform (CWT)

- **Wavelet Properties**: Derivation and scaling of the Mexican Hat wavelet, along with its spectral and temporal characteristics.
- **Wavelet Decomposition**: Continuous wavelet decomposition was applied to multi-frequency signals to extract distinct components using the Mexican Hat wavelet.

### Key Insights:
- Increased scale broadens the wavelet in the time domain while narrowing its spectral profile, optimizing lower-frequency capture.
- Frequency components of signals were accurately identified through spectral analysis.

---

## Discrete Wavelet Transform (DWT)

- **Wavelet Toolbox in MATLAB**: Decomposed signals using Haar and Db9 wavelets.
- **Coefficient Analysis**: Approximation and detail coefficients extracted with the `wavedec()` function for further analysis.

---

## Signal Denoising with DWT

- **Approach**: Denoising was performed using thresholding on wavelet coefficients.
- **Comparison**:
  - Db9 wavelet showed better performance for preserving morphology of specific signals.
  - Haar wavelet excelled in minimizing distortion for some cases.

### Results:
- **RMSE Values**:
  - Db9: Y1 = 0.3445, Y2 = 0.3086
  - Haar: Y1 = 0.3992, Y2 = 0.0512

---

## Signal Compression with DWT

- **Energy Retention**: Evaluated the number of wavelet coefficients needed to represent 99% energy of the signal.
- **Compression Ratios**: Optimized by removing less significant coefficients while maintaining key features of the signal.

### Outcome:
- Compressed signals retained essential morphology and features with minimal information loss.

---

## Repository Structure

- `src/`: MATLAB scripts for wavelet analysis.
- `data/`: Sample datasets used for testing.
- `results/`: Generated plots, spectrograms, and performance metrics.
- `docs/`: Additional documentation and this README.

---

## How to Use

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
