% NAIVE BAYES TESTS

% load the trained model and the scripts with the passwords
load('trainedNaiveBayes.mat');

common_passwords = readlines('common_passwords.txt');
strong_passwords = readlines('strong_passwords.txt');

% select 5% of each group
num_common = round(length(common_passwords) * 0.05);
num_strong = round(length(strong_passwords) * 0.05);

common_sample = common_passwords(randperm(length(common_passwords), num_common));
strong_sample = strong_passwords(randperm(length(strong_passwords), num_strong));

% add passwords that don't belong to any group
external_passwords = {'TotallyNew#Pass'; 'Unkown@Password'; 'NotInList123'};

% combine the three samples to the test
test_passwords = [common_sample; strong_sample; external_passwords];

% create true labels for the test_passwords
true_labels = [repmat("compromised", num_common, 1); 
               repmat("strong", num_strong, 1); 
               repmat("strong", length(external_passwords), 1)];


true_positive = 0;
true_negative = 0;
false_positive = 0;
false_negative = 0;

disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')

% loop for each password of test_passwords
for i = 1:length(test_passwords)
    
    test_password = char(test_passwords{i});
    true_label = true_labels{i};
    
    chars_test = unique(test_password);
    
    probs_compromised = zeros(length(chars_test), 1); 

    fprintf('Passowrd: %s  ------------  ', string(test_password))
    
    % calculate probabilities for 'compromised'
    for j = 1:length(chars_test)

        if ~ismember(chars_test(j), chars)
            probs_compromised(j) = [];
            continue
        end
    
        % find character index and calculate conditional probability
        index = find(chars_test(j) == chars);
        char_count = sum(occurences_compromised(:, index)); 
        prob = (char_count + 1) / (sum(sum(occurences_compromised)) + length(chars));
        probs_compromised(j) = prob;
    end

    probs_strong = zeros(length(chars_test), 1);
    
    % calculate probabilities for 'strong'
    for j = 1:length(chars_test)
         
        if ~ismember(chars_test(j), chars)
            probs_strong(j) = [];
            continue
        
        end
    
        % find character index and calculate conditional probability
        index = find(chars_test(j) == chars);
        char_count = sum(occurences_strong(:, index)); 
        prob = (char_count + 1) / (sum(sum(occurences_strong)) + length(chars));
        probs_strong(j) = prob;
    end
    
    % calculate the posterior probability for 'compromised'
    nbc_compromised = p_compromised * prod(probs_compromised(probs_compromised > 0));
    
    for j = 1:length(probs_compromised)
        nbc_compromised = nbc_compromised * probs_compromised(j);
    end
    
    % calculate the posterior probability for 'strong'
    nbc_strong = p_strong * prod(probs_strong(probs_strong > 0));

    for j = 1:length(probs_strong)
        nbc_strong = nbc_strong * probs_strong(j);
    end

    % sort based on posterior probabilities
    predicted_label = 'strong';

    if nbc_compromised > nbc_strong
        predicted_label = 'compromised';
    end

    if strcmp(predicted_label, 'compromised') && strcmp(true_label, 'compromised')
        true_positive = true_positive + 1;

    elseif strcmp(predicted_label, 'strong') && strcmp(true_label, 'strong')
        true_negative = true_negative + 1;

    elseif strcmp(predicted_label, 'compromised') && strcmp(true_label, 'strong')
        false_positive = false_positive + 1;

    elseif strcmp(predicted_label, 'strong') && strcmp(true_label, 'compromised')
        false_negative = false_negative + 1;
    end


    fprintf('Predicted: %s   -->   True one: %s \n', string(predicted_label), true_label)

end

disp(' ')

% calculate performance metrics
accuracy = (true_positive + true_negative) / size(test_passwords, 1);
precision = true_positive / (true_positive + false_positive);
recall = true_positive / (true_positive + false_negative);
f1 = 2 * (precision * recall) / (precision + recall);

fprintf('Accuracy: %2f \n', accuracy)
fprintf('Precision: %2f \n', precision)
fprintf('Recall: %2f \n', recall)
fprintf('f1: %2f \n', f1)

disp(' ')
disp('------ TESTS COMPLETED ------')
