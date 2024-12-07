function [hash2] = string2hashcode_2(str, k)
    
    % generates different k hash values for the given string (str)
    % str - string to be converted
    % k - number of hash values to be generated
    % hash2 - vector with the hash 'k' values generated

    hash2 = zeros(1, k);
    str = double(str); 

    hash = 5381 * ones(size(str, 1), 1); 
    
    % iterates on each caracter of the string (ASCII format)
    for i = 1:size(str, 2) 
        hash = mod(hash * 33 + str(i), 2^32 - 1);
    end

    % generates differentes k hashes
    for i = 1:k     
        str = num2str(i);
        hash = mod(hash * 33 + str, 2^32 - 1);
        hash2(i) = hash;
    end
end