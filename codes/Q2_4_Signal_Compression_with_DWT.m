% 2.4. Signal Compression with DWT

clearvars;
close all;
clc;

%load signal
load('ECGsig.mat')

% i. Obtain the discrete wavelet coefficients
[C_db9, L_db9] = wavedec(aVR, 10, 'db9');
[C_haar, L_haar] = wavedec(aVR, 10, 'haar');


%--------------------------------------------------------------------------

% ii. Arrange the coefficients in the descending order and find the number of coefficients which 
% are required to represent 99% of the energy of the signal.

% Sort coefficients by absolute magnitude in descending order
sorted_C_db9 = sort(abs(C_db9), 'descend');
sorted_C_haar = sort(abs(C_haar), 'descend');

% Find number of coefficients for 99% energy
cumulative_energy_db9 = cumsum(sorted_C_db9.^2);
cumulative_energy_haar = cumsum(sorted_C_haar.^2);

% Calculate the total energy of the signal
total_energy_db9 = sum(C_db9.^2);
total_energy_haar = sum(C_haar.^2);


figure;
subplot(2,1,1);
plot(100*cumulative_energy_db9/total_energy_db9);
title('Cumulative Energy - Db9');
xlabel('Number of Coefficients');
ylabel('Energy Percentage');
legend('Db9');

subplot(2,1,2);
plot(100*cumulative_energy_haar/total_energy_haar);
title('Cumulative Energy - Haar');
xlabel('Number of Coefficients');
ylabel('Energy Percentage');
legend('Haar');

% Determine the index where cumulative energy reaches 99% of total energy
num_coeffs_db9 = find(cumulative_energy_db9 >= 0.99 * total_energy_db9, 1);
num_coeffs_haar = find(cumulative_energy_haar >= 0.99 * total_energy_haar, 1);

fprintf('Number of coefficients for 99%% energy (db9): %d\n', num_coeffs_db9);
fprintf('Number of coefficients for 99%% energy (haar): %d\n', num_coeffs_haar);


%--------------------------------------------------------------------------

% iii. Compress the signal and find the compression ratio. Comment on the morphology of the 
% reconstructed signal and the compression ratio.

% Retain only the required number of coefficients for db9
C_db9_compressed = C_db9;
C_db9_compressed(abs(C_db9_compressed) < sorted_C_db9(num_coeffs_db9)) = 0;

% Retain only the required number of coefficients for haar
C_haar_compressed = C_haar;
C_haar_compressed(abs(C_haar_compressed) < sorted_C_haar(num_coeffs_haar)) = 0;

% Calculate compression ratio
compression_ratio_db9 = length(C_db9) / num_coeffs_db9;
compression_ratio_haar = length(C_haar) / num_coeffs_haar;

fprintf('Compression Ratio (db9): %.2f\n', compression_ratio_db9);
fprintf('Compression Ratio (haar): %.2f\n', compression_ratio_haar);

% Reconstruct the compressed signals
reconstructed_db9 = waverec(C_db9_compressed, L_db9, 'db9');
reconstructed_haar = waverec(C_haar_compressed, L_haar, 'haar');

% Plot the original and reconstructed signals
figure;
subplot(2,1,1);
plot(aVR, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(reconstructed_db9, 'r', 'DisplayName', 'Reconstructed (db9)');
title('Original vs Reconstructed Signal (db9)');
xlabel('Sample Index');
ylabel('Amplitude');
legend;

subplot(2,1,2);
plot(aVR, 'b', 'DisplayName', 'Original Signal');
hold on;
plot(reconstructed_haar, 'r', 'DisplayName', 'Reconstructed (haar)');
title('Original vs Reconstructed Signal (haar)');
xlabel('Sample Index');
ylabel('Amplitude');
legend;

save('original_wav_coeff_of_ECG.mat', 'C_haar'); 
save('compressed_wav_coeff_of_ECG.mat', 'C_haar_compressed'); 