function [BloomFilter] = add_element(BloomFilter,element, k)

    % adds an element to the Bloom Filter

    key = element;
    
    for func = 1:k
        key = [key num2str(func)];
        hash_code = string2hash(key);
        hash_code = mod(hash_code, length(BloomFilter)) + 1;
        BloomFilter(hash_code) = 1;
    end
end