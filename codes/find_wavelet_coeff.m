function [a10, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]  = find_wavelet_Coeff(signal, wavelet, tag)
    
    %   Computes and visualizes the wavelet coefficients of a signal.
    %
    %   Inputs:
    %       - signal : The input signal to be decomposed.
    %       - wavelet : The type of wavelet to be used for decomposition (e.g., 'db9').
    %       - tag : A string used for figure naming to help identify different plots.
    %
    %   Outputs:
    %       - a10 : Approximation coefficients at level 10.
    %       - d1, d2, ..., d10 : Detail coefficients at levels 1 to 10.
    
    % Decompose the signal
    [coeff_db9, lengths_db9] = wavedec(signal, 10, wavelet);

    % Extract the approximation coefficients at level 10
    a10 = appcoef(coeff_db9, lengths_db9, wavelet, 10);

    % Extract detail coefficients from level 1 to 10
    [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10] ...
        = detcoef(coeff_db9, lengths_db9, [1 2 3 4 5 6 7 8 9 10]);
    
    relevant_d_coefficients = zeros(10, 1024);

    for i = 1:10
        coeff_name = sprintf('d%d', i);
        coeff = eval(coeff_name);
        relevant_array = find_relevant_coefficients(coeff, length(coeff), i);
        relevant_d_coefficients(i, 1:length(relevant_array)) = relevant_array;
    end
    
    % remove redundant coefficients due to the convolution
    relevant_a_coefficients =  zeros(1, 1024);
    relevant_a_coefficients(1, 1:round(1024/2^10)) = find_relevant_coefficients(a10, length(a10), 10);

    % Plot detailed and approximation coefficients
    figure('Name', tag , 'NumberTitle', 'off');

    subplot(4,1,1);
    a10 = prepare_data( relevant_a_coefficients(1, 1:round(1024/2^10)) , 1024);
    stem(a10);
    title('a^1^0');

    subplot(4,1,2);
    d1 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^1)) , 1024);
    stem(d1);
    title('d^1');

    subplot(4,1,3);
    d2 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^2)) , 1024);
    stem(d2);
    title('d^2');

    subplot(4,1,4);
    d3 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^3)) , 1024);
    stem(d3);
    title('d^3');

    figure('Name', tag, 'NumberTitle', 'off');

    subplot(4,1,1);
    d4 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^4)) , 1024);
    stem(d4);
    title('d^4');

    subplot(4,1,2);
    d5 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^5)) , 1024);
    stem(d5);
    title('d^5');

    subplot(4,1,3);
    d6 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^6)) , 1024);
    stem(d6);
    title('d^6');

    subplot(4,1,4);
    d7 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^7)) , 1024);
    stem(d7);
    title('d^7');

    figure('Name', tag , 'NumberTitle', 'off');

    subplot(3,1,1);
    d8 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^8)) , 1024);
    stem(d8);
    title('d^8');

    subplot(3, 1, 2);
    d9 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^9)) , 1024);
    stem(d9);
    title('d^9');

    subplot(3, 1, 3);
    d10 = prepare_data( relevant_d_coefficients(1, 1:round(1024/2^10)) , 1024);
    stem(d10);
    title('d^1^0');
end
