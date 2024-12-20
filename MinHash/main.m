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

save('MinHashSignatures.mat', 'compromisedSignatures', 'compromised')
