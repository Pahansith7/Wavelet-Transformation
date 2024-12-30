% 2.3. Signal Denoising with DWT 

clearvars;
close all;
clc;

rng(10);

n = 0:1023;     % Signal length
fs = 512;       % Sampling Rate

% Define signal x1[n]
x1 = zeros(size(n));    
x1(n >= 0 & n < 512) = 2*sin((1/fs)* 20 * pi * n(n >= 0 & n < 512)) + ...
                      sin((1/fs)*80 * pi * n(n >= 0 & n < 512));

x1(n >= 512 & n < 1024) = 0.5*sin((1/fs)* 40 * pi * n(n >= 512 & n < 1024)) + ...
                      sin((1/fs)*60 * pi * n(n >= 512 & n < 1024));

%Define x2[n]
x2 = zeros(size(n)); 
x2(n >= 0 & n < 64) = 1;
x2(n >= 64 & n < 128) = 2;
x2(n >= 128 & n < 512) = -1;
x2(n >= 512 & n < 704) = 3;
x2(n >= 704 & n < 960) = 1;

% corrupt the signals
snr = 10;
y1 = awgn(x1, snr, 'measured');
y2 = awgn(x2, snr, 'measured');

% y1 db9
[C_y1_db9, L_y1_db9] = wavedec(y1, 10, 'db9');
[C_y1_haar, L_y1_haar] = wavedec(y1, 10, 'haar');
[C_y2_db9, L_y2_db9] = wavedec(y2, 10, 'db9');
[C_y2_haar, L_y2_haar] = wavedec(y2, 10, 'haar');

C_y1_db9_abs = abs(C_y1_db9); % Get absolute values
sorted_C_y1_db9_abs = sort(C_y1_db9_abs, 'descend'); % Sort in descending order

figure('Name', 'sorted_C_y1_db9_abs', 'NumberTitle', 'off');
stem(sorted_C_y1_db9_abs);
title('Wavelet Coefficients in Descending Order');
xlabel('Coefficient Index');
ylabel('Magnitude');

threshold_y1_db9 = 0.5;

C_y1_db9_denoised = C_y1_db9;
C_y1_db9_denoised(abs(C_y1_db9_denoised) < threshold_y1_db9) = 0;
denoised_y1_db9 = waverec(C_y1_db9_denoised, L_y1_db9, 'db9');

rmse_y1_db9 = sqrt(mean((x1 - denoised_y1_db9 ).^2));
fprintf('rmse between original signal x1 and denoised y1 signal using db9: %.14f\n', rmse_y1_db9);


figure('Name', 'denosied_y1_db9', 'NumberTitle', 'off');
plot(x1, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(denoised_y1_db9 , 'r', 'DisplayName', 'Denoised Signal');
legend;
title('Original vs Denoised Signal');
xlabel('Sample Index');
ylabel('Amplitude');


%--------------------------------------------------------------------------

%y1 haar
C_y1_haar_abs = abs(C_y1_haar); % Get absolute values
sorted_C_y1_haar_abs = sort(C_y1_haar_abs, 'descend'); % Sort in descending order

figure('Name', 'sorted_C_y1_haar_abs', 'NumberTitle', 'off');
stem(sorted_C_y1_haar_abs);
title('Wavelet Coefficients in Descending Order');
xlabel('Coefficient Index');
ylabel('Magnitude');

threshold_y1_haar = 0.5;

C_y1_haar_denoised = C_y1_haar;
C_y1_haar_denoised(abs(C_y1_haar_denoised) < threshold_y1_haar) = 0;
denoised_y1_haar = waverec(C_y1_haar_denoised, L_y1_haar, 'haar');

rmse_y1_haar = sqrt(mean((x1 - denoised_y1_haar).^2));
fprintf('rmse between original signal x1 and denoised y1 signal using haar: %.14f\n', rmse_y1_haar);

figure('Name', 'denoised_y1_haar', 'NumberTitle', 'off');
plot(x1, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(denoised_y1_haar, 'r', 'DisplayName', 'Denoised Signal');
legend;
title('Original vs Denoised Signal');
xlabel('Sample Index');
ylabel('Amplitude');


%--------------------------------------------------------------------------

% y2 db9

C_y2_db9_abs = abs(C_y2_db9); % Get absolute values
sorted_C_y2_db9_abs = sort(C_y2_db9_abs, 'descend'); % Sort in descending order

figure('Name', 'sorted_C_y2_db9_abs', 'NumberTitle', 'off');
stem(sorted_C_y2_db9_abs);
title('Wavelet Coefficients in Descending Order');
xlabel('Coefficient Index');
ylabel('Magnitude');

threshold_y2_db9 = 2.5;

C_y2_db9_denoised = C_y2_db9;
C_y2_db9_denoised(abs(C_y2_db9_denoised) < threshold_y2_db9) = 0;
denoised_y2_db9 = waverec(C_y2_db9_denoised, L_y2_db9, 'db9');

rmse_y2_db9 = sqrt(mean((x2 - denoised_y2_db9 ).^2));
fprintf('rmse between original signal x2 and denoised y2 signal using db9: %.14f\n', rmse_y2_db9);

figure('Name', 'denosied_y2_db9', 'NumberTitle', 'off');
plot(x2, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(denoised_y2_db9 , 'r', 'DisplayName', 'Denoised Signal');
legend;
title('Original vs Denoised Signal');
xlabel('Sample Index');
ylabel('Amplitude');

%--------------------------------------------------------------------------

% y2 haar

C_y2_haar_abs = abs(C_y2_haar); % Get absolute values
sorted_C_y2_haar_abs = sort(C_y2_haar_abs, 'descend'); % Sort in descending order

figure('Name', 'sorted_C_y2_haar_abs', 'NumberTitle', 'off');
stem(sorted_C_y2_haar_abs);
title('Wavelet Coefficients in Descending Order');
xlabel('Coefficient Index');
ylabel('Magnitude');

threshold_y2_haar = 2.5;

C_y2_haar_denoised = C_y2_haar;
C_y2_haar_denoised(abs(C_y2_haar_denoised) < threshold_y2_haar) = 0;
denoised_y2_haar = waverec(C_y2_haar_denoised, L_y2_haar, 'haar');

rmse_y2_haar = sqrt(mean((x2 - denoised_y2_haar).^2));
fprintf('rmse between original signal x2 and denoised y2 signal using haar: %.14f\n', rmse_y2_haar);

figure('Name', 'denoised_y2_haar', 'NumberTitle', 'off');
plot(x2, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(denoised_y2_haar, 'r', 'DisplayName', 'Denoised Signal');
legend;
title('Original vs Denoised Signal');
xlabel('Sample Index');
ylabel('Amplitude');
