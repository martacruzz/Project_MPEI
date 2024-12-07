function [similarities, similarPasswords] = GetSimilarities(passwords, signatures, inputSignature, threshold, k)

    numPasswords = length(passwords);
    similarities = zeros(numPasswords , 1);
    similarPasswords = {};
    
    for i = 1:numPasswords
        similarities(i) = sum(inputSignature == signatures(i, :)) / k;
    
        if similarities(i) > threshold

            similarPasswords{end + 1} = passwords{i}; % append
        
        end
    
    end

end