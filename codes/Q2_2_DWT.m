% 2.2.Applying DWT with the Wavelet Toolbox in MATLAB 

clearvars;
close all;
clc;

% i. Create Waveforms

rng(10);

n = 0:1023;     % Signal length
fs = 512;       % Sampling Rate

% Define signal x1[n]
x1 = zeros(size(n));    
x1(n >= 0 & n < 512) = 2*sin((1/fs)* 20 * pi * n(n >= 0 & n < 512)) + ...
                      sin((1/fs)*80 * pi * n(n >= 0 & n < 512));

x1(n >= 512 & n < 1024) = 0.5*sin((1/fs)* 40 * pi * n(n >= 512 & n < 1024)) + ...
                      sin((1/fs)*60 * pi * n(n >= 512 & n < 1024));
  
% Plot the signal x1[n]
figure('Name', 'x_1[n]', 'NumberTitle', 'off');
plot(n, x1);
xlabel('n');
ylabel('Amplitude');
xlim([0 1024]);
ylim([-3.5 3.5]);
title('Waveform x_1[n]');


%Define x2[n]
x2 = zeros(size(n)); 
x2(n >= 0 & n < 64) = 1;
x2(n >= 64 & n < 128) = 2;
x2(n >= 128 & n < 512) = -1;
x2(n >= 512 & n < 704) = 3;
x2(n >= 704 & n < 960) = 1;

% Plot the signal x2[n]
figure('Name', 'x_2[n]', 'NumberTitle', 'off');
plot(n, x2);
xlabel('n');
ylabel('Amplitude');
xlim([0 1024]);
ylim([-1.5 3.5]);
title('Waveform x_2[n]');

% corrupt the signals

snr = 10;

y1 = awgn(x1, snr, 'measured');

figure('Name', 'x_1[n] & y_1[n]', 'NumberTitle', 'off');
plot(n,  x1, n, y1);
xlabel('n');
ylabel('Amplitude');
xlim([0 1024]);
ylim([-3.5 3.5]);
title('Original and Corrupted Waveforms');
legend('x1', 'y1');

y2 = awgn(x2, snr, 'measured');

figure('Name', 'x_2[n] & y_2[n]', 'NumberTitle', 'off');
plot(n, x2, n, y2);
xlabel('n');
ylabel('Amplitude');
xlim([0 1024]);
ylim([-1.5 3.5]);
title('Original and Corrupted Waveforms');
legend('x2', 'y2');


%--------------------------------------------------------------------------

% ii. Observe the morphology of the wavelet and scaling functions of Haar 
% and Daubechies tap 9

% Haar Wavelet
[phi_haar, psi_haar, x_haar] = wavefun('haar', 10); % Get wavelet and scaling functions

figure('Name', 'haar Wavelet', 'NumberTitle', 'off');
subplot(2, 1, 1);
plot(x_haar, phi_haar);
title('Haar Scaling Function');
xlabel('Time');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(x_haar, psi_haar);
title('Haar Wavelet Function');
xlabel('Time');
ylabel('Amplitude');

% daubechies 9-Tap Wavelet (db9)
[phi_db9, psi_db9, x_db9] = wavefun('db9', 10);

figure('Name', 'db9 wavelet', 'NumberTitle', 'off');
subplot(2, 1, 1);
plot(x_db9, phi_db9);
title('daubechies 9-Tap Scaling Function');
xlabel('Time');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(x_db9, psi_db9);
title('daubechies 9-Tap Wavelet Function');
xlabel('Time');
ylabel('Amplitude');


%--------------------------------------------------------------------------

% iii. Calculate the 10-level wavelet decomposition of the signal using wavelet ‘db9’ and ‘haar’. 

%  For y1 with 'db9' wavelet
% [a10_y1_db9, d1_y1_db9, d2_y1_db9, d3_y1_db9, d4_y1_db9, d5_y1_db9, ...
%  d6_y1_db9, d7_y1_db9, d8_y1_db9, d9_y1_db9, d10_y1_db9] = find_wavelet_coeff(y1, 'db9', "y1_db9_");


% % % For y2 with 'db9' wavelet
% [a10_y2_db9, d1_y2_db9, d2_y2_db9, d3_y2_db9, d4_y2_db9, d5_y2_db9, ...
%  d6_y2_db9, d7_y2_db9, d8_y2_db9, d9_y2_db9, d10_y2_db9] = find_wavelet_coeff(y2, 'db9', "y2_db9_");
% 
% % % For y1 with 'haar' wavelet
% [a10_y1_haar, d1_y1_haar, d2_y1_haar, d3_y1_haar, d4_y1_haar, d5_y1_haar, ...
%  d6_y1_haar, d7_y1_haar, d8_y1_haar, d9_y1_haar, d10_y1_haar] = find_wavelet_coeff(y1, 'haar', "y1_haar_");
% 
% % % For y2 with 'haar' wavelet
[a10_y2_haar, d1_y2_haar, d2_y2_haar, d3_y2_haar, d4_y2_haar, d5_y2_haar, ...
 d6_y2_haar, d7_y2_haar, d8_y2_haar, d9_y2_haar, d10_y2_haar] = find_wavelet_coeff(y2, 'haar', "y2_haar_");
 

%--------------------------------------------------------------------------
% iv. Use the inverse DWT to reconstruct A10, D10, D9, …., D2, D1 and verify that ? = ? ?? + ? 
% by calculating the energy between original and reconstructed signal.

% y1 with db9--------------------------------------------------------------

[C_y1_db9, L_y1_db9] = wavedec(y1, 10, 'db9');
D_y1_db9 = cell(1, 10);
A_y1_db9 = cell(1, 1);

for i = 1:10
    D_y1_db9{i} = wrcoef('d', C_y1_db9, L_y1_db9, 'db9', i);
end
A_y1_db9{1} = wrcoef('a', C_y1_db9, L_y1_db9, 'db9', 10);

figure('Name', 'y1_db9_det_approx_fn', 'NumberTitle', 'off');
subplot(11, 1, 1);
plot(A_y1_db9{1});
title(['A^' num2str(10)]);

for i = 1:10
    subplot(11, 1, i+1);
    plot(D_y1_db9{i});
    title(['D^' num2str(i)]);
end

y1_wrec_db9 = 0;
for i = 1:10
    y1_wrec_db9 = y1_wrec_db9 + D_y1_db9{i};
end
y1_wrec_db9 = y1_wrec_db9 + A_y1_db9{1};

figure('Name', 'y1_wrec_db9', 'NumberTitle', 'off');
plot(y1_wrec_db9);
title('Reconstructed y1 with db9 wavelet');
energy_diff_y1_db9 = sum(y1.^2)- sum(y1_wrec_db9.^2);
fprintf('energy differnece between y1 and reconstructed y1 using db9: %.14f\n', abs(energy_diff_y1_db9));


% y1 with haar ------------------------------------------------------------

[C_y1_haar, L_y1_haar] = wavedec(y1, 10, 'haar');
D_y1_haar = cell(1, 10);
A_y1_haar = cell(1, 1);

for i = 1:10
    D_y1_haar{i} = wrcoef('d', C_y1_haar, L_y1_haar, 'haar', i);
end
A_y1_haar{1} = wrcoef('a', C_y1_haar, L_y1_haar, 'haar', 10);

figure('Name', 'y1_haar_det_approx_fn', 'NumberTitle', 'off');
subplot(11, 1, 1);
plot(A_y1_haar{1});
title(['A^' num2str(10)]);

for i = 1:10
    subplot(11, 1, i+1);
    plot(D_y1_haar{i});
    title(['D^' num2str(i)]);
end

y1_wrec_haar = 0;
for i = 1:10
    y1_wrec_haar = y1_wrec_haar + D_y1_haar{i};
end
y1_wrec_haar = y1_wrec_haar + A_y1_haar{1};

figure('Name', 'y1_wrec_haar', 'NumberTitle', 'off');
plot(y1_wrec_haar);
title('Reconstructed y1 with haar wavelet');
energy_diff_y1_haar = sum(y1.^2)- sum(y1_wrec_haar.^2);
fprintf('energy differnece between y1 and reconstructed y1 using haar: %.14f\n', abs(energy_diff_y1_haar));


% y2 with db9--------------------------------------------------------------

[C_y2_db9, L_y2_db9] = wavedec(y2, 10, 'db9');
D_y2_db9 = cell(1, 10);
A_y2_db9 = cell(1, 1);

for i = 1:10
    D_y2_db9{i} = wrcoef('d', C_y2_db9, L_y2_db9, 'db9', i);
end
A_y2_db9{1} = wrcoef('a', C_y2_db9, L_y2_db9, 'db9', 10);

figure('Name', 'y2_db9_det_approx_fn', 'NumberTitle', 'off');
subplot(11, 1, 1);
plot(A_y2_db9{1});
title(['A^' num2str(10)]);

for i = 1:10
    subplot(11, 1, i+1);
    plot(D_y2_db9{i});
    title(['D^' num2str(i)]);
end

y2_wrec_db9 = 0;
for i = 1:10
    y2_wrec_db9 = y2_wrec_db9 + D_y2_db9{i};
end
y2_wrec_db9 = y2_wrec_db9 + A_y2_db9{1};

figure('Name', 'y2_wrec_db9', 'NumberTitle', 'off');
plot(y2_wrec_db9);
title('Reconstructed y2 with db9 wavelet');
energy_diff_y2_db9 = sum(y2.^2)- sum(y2_wrec_db9.^2);
fprintf('energy differnece between y2 and reconstructed y2 using db9: %.14f\n', abs(energy_diff_y2_db9));



% y2 with haar-------------------------------------------------------------

[C_y2_haar, L_y2_haar] = wavedec(y2, 10, 'haar');
D_y2_haar = cell(1, 10);
A_y2_haar = cell(1, 1);

for i = 1:10
    D_y2_haar{i} = wrcoef('d', C_y2_haar, L_y2_haar, 'haar', i);
end
A_y2_haar{1} = wrcoef('a', C_y2_haar, L_y2_haar, 'haar', 10);

figure('Name', 'y2_haar_det_approx_fn', 'NumberTitle', 'off');
subplot(11, 1, 1);
plot(A_y2_haar{1});
title(['A^' num2str(10)]);

for i = 1:10
    subplot(11, 1, i+1);
    plot(D_y2_haar{i});
    title(['D^' num2str(i)]);
end

y2_wrec_haar = 0;
for i = 1:10
    y2_wrec_haar = y2_wrec_haar + D_y2_haar{i};
end
y2_wrec_haar = y2_wrec_haar + A_y2_haar{1};

figure('Name', 'y2_wrec_haar', 'NumberTitle', 'off');
plot(y2_wrec_haar);
title('Reconstructed y2 with haar wavelet');
energy_diff_y2_haar = sum(y2.^2)- sum(y2_wrec_haar.^2);
fprintf('energy differnece between y2 and reconstructed y2 using haar: %.14f\n', abs(energy_diff_y2_haar));



