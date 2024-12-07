function [BloomFilter] = init_filter(n)
    
    % this functions creates and initialize the Bloom Filter
    % n - size of the filter ( number of bits on the bits matrix)
    % BloomFilter - vector of size n with all the values initialize as 0

    BloomFilter = zeros(n, 1, 'uint8');

end