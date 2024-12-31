# Wavelet-Based Bio-Signal Processing and Analysis

## Project Overview
This project explores the use of wavelet transforms for bio-signal processing, focusing on ECG signals. Techniques implemented include signal decomposition, denoising, and compression using both continuous and discrete wavelet transforms. The project evaluates and compares the performance of various wavelets such as the Mexican Hat, Haar, and Daubechies 9-tap (Db9).

---

## Contents

### **1. Continuous Wavelet Transform (CWT)**  
- **Wavelet properties**: Derived and normalized the Mexican Hat wavelet, demonstrating zero mean, unity energy, and compact support.
- **Wavelet decomposition**: Applied CWT to signals with distinct frequency components, analyzing temporal and spectral characteristics.
- **Insights**: Broadening in time-domain resolution with increased scale and narrowing in frequency domain for low-frequency component capture.  
  ![image](https://github.com/user-attachments/assets/cwt-example)

---

### **2. Discrete Wavelet Transform (DWT)**  
- **Wavelet Toolbox in MATLAB**: Decomposed signals into approximation and detail coefficients using Haar and Db9 wavelets.
- **Coefficient extraction**: Used MATLAB functions `wavedec()`, `appcoef()`, and `detcoef()` for multi-level decomposition.  
  ![image](https://github.com/user-attachments/assets/dwt-coefficients)

---

### **3. Signal Denoising with DWT**  
- **Thresholding approach**: Suppressed coefficients below a threshold and reconstructed signals using `waverec()`. 
- **Comparison**:
  - Db9 wavelet performed better for preserving morphology (e.g., RMSE = 0.3445 for Y1).
  - Haar wavelet excelled for minimal distortion (e.g., RMSE = 0.0512 for Y2).  
  ![image](https://github.com/user-attachments/assets/denoising-performance)

---

### **4. Signal Compression with DWT**  
- **Energy retention**: Retained 99% of the signal energy by keeping the most significant coefficients.
- **Compression ratio**: Calculated based on the number of retained coefficients and total coefficients.
- **Insights**: Effective signal compression with minor losses in morphological details.  
  ![image](https://github.com/user-attachments/assets/compression-visualization)

---

## Optimizations
- **Wavelet types**: Compared performance across Mexican Hat, Haar, and Db9.
- **Parameters**: Explored threshold selection, decomposition levels, and cumulative energy analysis.

---

## Evaluation Metrics
- **Denoising performance**: Root Mean Squared Error (RMSE).
- **Compression efficiency**: Compression Ratio (CR) and energy retention.

---

## Frameworks and Tools
- **Programming Language**: MATLAB  
- **Wavelet Toolbox**: For signal decomposition, reconstruction, and analysis.

---

## Key Results
1. **CWT**:
   - Effective at identifying frequency components in time-varying signals.
2. **DWT**:
   - Haar wavelet showed superior signal reconstruction in certain cases.
3. **Signal Denoising**:
   - Db9 wavelet preserved signal morphology better for high-frequency components.
4. **Signal Compression**:
   - Compression achieved without significant loss of information.

---

## How to Use

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
