function middle_coeff = find_relevant_coefficients(x, M, k)
    L = 1024/(2^k);
    start_index = floor((M - L) / 2) + 1;
    end_index = start_index + L - 1; 
    middle_coeff = x(start_index:end_index);
end

    
    
