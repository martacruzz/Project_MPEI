function [BloomFilter] = add_element(BloomFilter,element, k)

    % adds an element to the Bloom Filter
    % BloomFilter - bits matrix of the Bloom Filter
    % element - element (string) that's gonna be added to the filter
    % k - number of used hash functions
    % BloomFilter (exit) - updated filter with the added element

    key = element;
    
    for func = 1:k
        key = [key num2str(func)];
        hash_code = string2hash(key);
        hash_code = mod(hash_code, length(BloomFilter)) + 1;
        BloomFilter(hash_code) = 1;
    end
end