function [result] = is_in_BloomFilter(BloomFilter, element, k)
    
    % verifies if an element (string) is present in the Bloom Filter
    % BloomFilter - bits matrix that represents the filter
    % element - the element (string) to be checked
    % k - number of used hash functions
    % result - returns 'true' if the elemente may be present in the filter, and 'false' otherwise

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