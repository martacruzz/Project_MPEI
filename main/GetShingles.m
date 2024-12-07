function [shingles] = GetShingles(password, k)

    % this function is responsibel for retrieveing the k-shingles
    % of a password passed in as an argument

    n = strlength(password);
    numShingles = n - k + 1;
    shingles = cell(numShingles, 1);

    for i = 1:numShingles

         shingles{i} = password(i:(i + k - 1));

    end

end