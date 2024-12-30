function [psi_values] = mexican_hat_wavelet(t, s)
    %   Computes the Mexican hat wavelet function values.
    %
    %   Inputs:
    %       - t : Time values (vector or scalar) at which to evaluate the wavelet.
    %       - s : Scale parameter controlling the width of the wavelet.
    %
    %   Output:
    %       - psi_values : Computed wavelet values corresponding to the input time `t` 
    %                      and scale `s`.
    
    psi_values = (2 / (sqrt(3*s) * pi^(1/4)))*(1 - (t/s).^2).* exp(-1*((t/s).^2 )/ 2);
    
end