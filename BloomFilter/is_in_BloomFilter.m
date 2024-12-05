function [result] = is_in_BloomFilter(BloomFilter, element, k)

    result = true;
    key = element;

    for func = 1:k
        key = [key num2str(func)];
        hash_code = string2hash(key);
        hash_code = mod(hash_code, length(BloomFilter)) + 1;
    
        if BloomFilter(hash_code) ~= 1
            result = false;
            break;
        end
    end
end