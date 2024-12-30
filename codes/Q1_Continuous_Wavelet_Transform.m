% Q1- Continuous Wavelet Transform

clearvars;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.2.Wavelet properties

% iv. & v. Generate the Mexican hat daughter wavelet for scaling factors of 0.01:0.1:2 and verify wavelet properties. 

fs = 250;           % Sample frequency
N = 3000;           % Data length
t = (-N:N)/fs;      % Time scale
s_values = 0.01:0.1:2;     % Values of scaling factor


figure('Name', 'Daughter wavelets at different scales', 'NumberTitle', 'off');
for i = 1:length(s_values)
    s = s_values(i);
    subplot(10,2,i);
    wavelet = mexican_hat_wavelet(t, s); % Generating the mexican hat daughter wavelet
    plot(t, wavelet, 'LineWidth',1); 
    title(['s = ', num2str(s)]);
    mean_value = abs(mean(wavelet));
    energy = trapz(t, wavelet.^2);
    fprintf('Scaling factor: %.2f   |   The mean of the wavelet is: %.5f   |   The energy of the wavelet is: %.5f\n',s, mean_value, energy)
end


%--------------------------------------------------------------------------

% vi.  plot spectra of daughter wavelets. 

figure('Name', 'Spectra of daughter wavelets at different scales - 1', 'NumberTitle', 'off');
for i = 1:2
    s = s_values(i);
    subplot(1,2,i);
    wavelet = mexican_hat_wavelet(t, s); % Generating the mexican hat daughter wavelet
    Fwavelt = fft(wavelet)/length(wavelet); % Generating spectra of wavelets
    hz = linspace(0,fs/2,floor(length(wavelet)/2)+1);
    plot(hz,2*abs(Fwavelt(1:length(hz))))
    title(['s = ', num2str(s)])
    xlim([0 60])
end

figure('Name', 'Spectra of daughter wavelets at different scales - 2', 'NumberTitle', 'off');
for i = 3:10
    s = s_values(i);
    subplot(4,2,i-2);
    wavelet = mexican_hat_wavelet(t, s);% Generating the mexican hat daughter wavelet
    Fwavelt = fft(wavelet)/length(wavelet);% Generating spectra of wavelets
    hz = linspace(0,fs/2,floor(length(wavelet)/2)+1);
    plot(hz,2*abs(Fwavelt(1:length(hz))))
    title(['s = ', num2str(s)])
    xlim([0 5])
end

figure('Name', 'Spectra of daughter wavelets at different scales - 3', 'NumberTitle', 'off');
for i = 11:20
    s = s_values(i);
    subplot(5,2,i-10);
    wavelet = mexican_hat_wavelet(t, s);% Generating spectra of wavelets
    Fwavelt = fft(wavelet)/length(wavelet); % Generating spectra of wavelets
    hz = linspace(0,fs/2,floor(length(wavelet)/2)+1);
    plot(hz,2*abs(Fwavelt(1:length(hz))))
    title(['s = ', num2str(s)])
    xlim([0 5])
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% i. Creating the waveform
n = 1:3*N;
x = zeros(size(n)); 
x(n >= 1 & n < (3*N)/2) = sin((1/fs)*0.5 * pi * n(n >= 1 & n < (3*N)/2));
x(n >= (3*N)/2 & n < 3*N) = sin((1/fs)*1.5 * pi * n(n >= (3*N)/2 & n < 3*N));

figure('Name', 'Waveform', 'NumberTitle', 'off');
plot(n/fs, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal');


%--------------------------------------------------------------------------

% ii. Apply the Mexican hat wavelet to achieve the translation
scales = 0.01:0.01:2; % Scale resolution
coefficients = zeros(length(scales), length(x)); % Initialize coefficient matrix

% Perform convolution for each scale
for i = 1:length(scales)
    scale = scales(i);
    wavelet = mexican_hat_wavelet(t, scale); % Scaled Mexican hat wavelet
    coefficients(i, :) = conv(x, wavelet, 'same'); % Convolve and store coefficients
end


%--------------------------------------------------------------------------

% iii. Visualize the spectrogram
figure('Name', 'Spectrogram', 'NumberTitle', 'off');
h = pcolor(n/fs, scales, coefficients);
set(h, 'EdgeColor', 'none');
colormap jet
xlabel('Time (s)')
ylabel('Scale')
title('Spectrogram')

