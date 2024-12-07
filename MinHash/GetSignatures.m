function [signatures] = GetSignatures(passwords, k, shingleSize)

    % GetSignatures is a function that calculates the signatures matrix for
    % a given set of passwords passed in as an argument

    N = length(passwords);
    signatures = inf(N, k);

    for i = 1:N % for each password

        password = convertStringsToChars(passwords(i)); % converts a string password to an array of chars
        shingles = GetShingles(password, shingleSize);

        for j = 1:length(shingles)

            shingle = shingles{j};
            hashcodes = string2hash_2(shingle, k);
            signatures(i,:) = min(signatures(i,:), hashcodes);

        end

    end



end