# Wavelet-Based Bio-Signal Processing and Analysis

## Project Overview
This project explores the application of wavelet transforms in bio-signal processing. It covers the study of wavelet properties, time-frequency analysis using continuous and discrete wavelet transforms, and signal denoising and compression through discrete wavelet transforms. The performance of various wavelets, including the Mexican Hat, Haar, and Daubechies 9-tap (Db9), is evaluated and compared.

---

## Contents

### **1. Wavelet Properties**  
- Derived the Mexican Hat wavelet mathematically, demonstrating zero mean, unity energy, compact support and analyzed the daughter wavelets and and their spectras.

### **2. Time Frequency Analysis Using the Continuous Wavelet Transformation**
- Applied CWT to signals with distinct frequency components, analyzing temporal and spectral characteristics.
- Signal:
  ![image](https://github.com/user-attachments/assets/6c5133b1-63f0-42ee-8e32-d03da2dff91c)
- Spectogram:
- ![image](https://github.com/user-attachments/assets/35bec46e-7a3d-4217-b6fa-7f7c9f92d87b)

---

### **3. Discrete Wavelet Transform (DWT)**  
- Decomposed various signals(signals with various shapes and noise levels) into approximation and detail coefficients using Haar and Db9 wavelets.
- Reconstructed the signal and analysed the effectiveness of Haar and Db9 wavelet for reconstructing the each signal.
- Ex: -
- Noisy(corrupted) signal(named y2 in the project) along with the noise free signal(x2).
- ![image](https://github.com/user-attachments/assets/3edda9c8-13b4-4a86-be1c-ec66ba5d8d47)
- A10, D10, D9, …., D2, D1 for signal y2 with haar wavelet.
- ![image](https://github.com/user-attachments/assets/1135ed4a-520d-4c5c-9fa4-00548fbcf6e6)
- FInal reconstructed signal(y2).
- ![image](https://github.com/user-attachments/assets/7fea36af-fd69-4058-bdb1-03ca8d0fe30f)

---

### **4. Signal Denoising with DWT**  
- Used a **Thresholding approach**; suppressed coefficients below a threshold and reconstructed; (used hard thresholding).
- Ex:-
- Denoising y2 signal with db9 wavelet and Haar wavelet. 
- Using db9:
- ![image](https://github.com/user-attachments/assets/81181f7d-6972-4697-bc06-6eef71c76650)
- Using Haar:
- ![image](https://github.com/user-attachments/assets/59f127e9-cde1-4961-ac61-e71e6d9fb5e7)
- Here we analyzed the importance of selecting the correct wavelet for signal denoising.

---

### **5. Signal Compression with DWT**  
- Retained 99% of the signal energy by keeping the most significant coefficients during the compression.
- Calculated the **Compression ratio** based on the number of retained coefficients and total coefficients.
- Ex:- (Original and reconstructed signals using compressed data; compression ratio - 16.08).
- ![image](https://github.com/user-attachments/assets/a41de314-6f73-401b-b6a3-2df6e3d9bdc7)

---

## Acknowledgment
This project was completed as part of the BM4152 Bio-Signal Processing course. 
