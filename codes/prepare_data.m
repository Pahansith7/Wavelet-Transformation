function new_array = prepare_data(original_array, new_length)
    n = length(original_array);
    new_array = zeros(1, new_length);
    for i = 1:n

        index = round((2*i-1)*(new_length/(2*n)));
        new_array(index) = original_array(i);
    end
end
