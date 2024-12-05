function [hash2] = string2hashcode_2(str, k)

    hash2 = zeros(1, k);
    str = double(str); 

    hash = 5381 * ones(size(str, 1), 1); 

    for i = 1:size(str, 2) 
        hash = mod(hash * 33 + str(i), 2^32 - 1);
    end

    
    for i = 1:k     
        str = num2str(i);
        hash = mod(hash * 33 + str, 2^32 - 1);
        hash2(i) = hash;
    end
end