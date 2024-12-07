function [hash2] = string2hash_2(str, k)

% string2hash_2 computes a more eficient way of creating hash codes (when k
% is really large) when compared to the original matlab string2hash
% function.
% Use it when generating a large number of hashes for a single input string,
% such as in applications like Bloom filters where multiple hash functions are applied to the same key.

% In this function the computation is made in 2 phases:
% - First, the hash is computed for the initial string str.
% - Then, for k iterations, it reuses the previous hash value and updates it 
% iteratively using the numeric value of the index i. This avoids processing 
% the characters of str repeatedly for each iteration, making the computation more efficient for large k.
% (The string str is processed only once to compute the initial hash. 
% Subsequent hashes are derived by processing the numeric representation 
% of i (via num2str(i)), which is typically much shorter than the original
% string str).

    hash2 = zeros(1, k); % will hold the k generated hash values
    str = double(str);   % converts the input string str into its ASCII numeric representation
                            % for example, the string 'abc' becomes the array [97, 98, 99]

    % code fetched from string2hash original function
    hash = 5381 * ones(size(str, 1), 1); % size(str, 1) -> number of rows in the matrix str

    for i = 1:size(str, 2) % size(str, 2) -> number of chars in str
                                % If str is an array of strings, hash becomes 
                                % a column vector with one element per string (i.e., each string gets its own hash value).
        
        hash = mod(hash * 33 + str(i), 2^32 - 1);

    end

    

    for i = 1:k         % each iteration of this loop produces one hash value and stores it in hash2

        %str = num2str(i);
        hash = mod(hash * 33 + i, 2^32 - 1);
        hash2(i) = hash;

    end

end