% this scipt holds the module for the Naive Bayes classifier to classify a
% given password as strong or compromised

% load files that hold compromised and strong passwords
compromised = readlines('common_passwords.txt');
compromised = strtrim(compromised);
strong = readlines("strong_passwords.txt");
strong = strtrim(strong);
N = length(compromised);

% build data matrix - holds all data
passwords = [compromised; strong];

% build categorical to hold classes: 1 - compromised; 0 - strong (not
% compromised)
classes = categorical([ones(N, 1); zeros(N, 1)], [0 1], {'strong', 'compromised'});

% fetch individual chars that compose each password
allChars = strjoin(passwords, '');
chars = unique(char(allChars)); % convert string to char array, otherwise unique does not work

% build matrix that will hold the amount of times each char appears in each
% password
occurrences = zeros(length(passwords), length(chars));

% populate occurences
for i = 1:length(passwords)

    password = passwords(i);

    for j = 1:length(chars)

        if contains(password, chars(j))

            occurrences(i,j) = occurrences(i,j) + count(password, chars(j));

        end

    end

end

% a priori probabilities
p_compromised = length(compromised) / length(passwords);
p_strong = length(strong) / length(passwords);

% separate occurences on practice set "compromised"
occurences_compromised = occurrences(1:N, :);
allChars_compromised = strjoin(compromised, '');
chars_compromised = unique(char(allChars_compromised));

% separate occurences on practice set "strong"
occurences_strong = occurrences(N+1:end, :);
allChars_strong = strjoin(strong, '');
chars_strong = unique(char(allChars_strong));

% midway situation output
disp("--------------------------")
fprintf("Number of unique characters on practice set: %d\n", length(chars));
fprintf("Number of unique characters on practice set 'compromised': %d\n", length(chars_compromised));
fprintf("Number of unique characters on practice set 'strong': %d\n", length(chars_strong));
fprintf("P(compromised) = %.4f\n", p_compromised)
fprintf("P(strong) = %.4f\n", p_strong)
disp("--------------------------")

save('trainedNaiveBayes.mat', 'chars', 'chars_compromised', 'chars_strong', 'p_compromised', 'p_strong', 'occurences_compromised', 'occurences_strong')

% test password
test_password = "[strP4ssw0rd@";
allChars_test = strjoin(test_password, '');
chars_test = unique(char(allChars_test));

% vector that will hold the probability of each character in test password to be
% within compromised passwords
probs_compromised = zeros(length(chars_test), 1); % the number of probabilities in this array will always be equal or less than the number of unique test characters

% populate probabilities array
for i = 1:length(chars_test)
    
    % check if character is in chars_test    
    if ~ismember(chars_test(i), chars)
            
        probs_compromised(i) = [];
        continue
    
    end

    index = find(chars_test(i) == chars);
    char_count = sum(occurences_compromised(:, index)); % number of times a certain char i appears in the compromised practice set

    prob = (char_count + 1) / (sum(sum(occurences_compromised)) + length(chars));
    probs_compromised(i) = prob;
    fprintf("P(%c | compromised) = %.6f\n", chars_test(i), prob);

end


probs_strong = zeros(length(chars_test), 1);

for i = 1:length(chars_test)
    
    % check if character is in chars_test    
    if ~ismember(chars_test(i), chars)
            
        probs_strong(i) = [];
        continue
    
    end

    index = find(chars_test(i) == chars);
    char_count = sum(occurences_strong(:, index)); % number of times a certain char i appears in the compromised practice set

    prob = (char_count + 1) / (sum(sum(occurences_strong)) + length(chars));
    probs_strong(i) = prob;
    fprintf("P(%c | strong) = %.4f\n", chars_test(i), prob);

end

disp("--------------------------")

% calculation of the later probability for compromised P(compromised | test password) 
nbc_compromised = p_compromised;

for i = 1:length(probs_compromised)
    nbc_compromised = nbc_compromised * probs_compromised(i);
end

% calculation of the later probability for strong P(strong | test password) 
nbc_strong = p_strong;
for i = 1:length(probs_strong)
    nbc_strong = nbc_strong * probs_strong(i);
end

% finally, compare the values and output an answer
if (nbc_compromised > nbc_strong)
    disp("Your password is most likely compromised. Better change it!")
else
    disp("Good job, you have a strong password. It is most likely not compromised")
end
