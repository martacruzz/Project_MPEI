% this scipt holds the module for the Naive Bayes classifier to classify a
% given password as strong or compromised

% load files that hold compromised and strong passwords
compromised = readlines('common_passwords.txt');
compromised = strtrim(compromised);
strong = readlines("strong_passwords.txt");
strong = strtrim(strong);

% build labeled matrix with all data - 0: compromised; 1:strong
compromisedTable = table(compromised, zeros(length(compromised), 1), 'VariableNames', {'Password', 'Label'});
strongTable = table(compromised, ones(length(strong), 1), 'VariableNames', {'Password', 'Label'});

data = [compromisedTable ; strongTable];