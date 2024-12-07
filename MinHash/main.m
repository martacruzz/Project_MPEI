% this script hold a basic implementation of the MinHash algorithm to check
% if password inputted by the user has any degree of similarity with
% the passwords held as compromised

% fetch compromised passwords from file
compromised = readlines('common_passwords.txt');
compromised = strtrim(compromised);

% compute signatures for compromised passwords
k = 200;
shingleSize = 3;
compromisedSignatures = GetSignatures(compromised, k, shingleSize);

inputPasword = "p4ssw0rdStr@ng";
threshold = 0.5;

inputSignature = GetSignatures(inputPasword, k, shingleSize);

% calculate Jaccard distances between input password and compromised
% passwords
[similarities, similars] = GetSimilarities(compromised, compromisedSignatures, inputSignature, threshold, k);

% display similar passwords
if ~isempty(similars)

    fprintf('Similar passwords found:\n');
    for i = 1:length(similars)
        fprintf('%2d. %s\n', i, similars{i}); % Display index and password
    end

else

    fprintf('No similar passwords found.\n');

end
