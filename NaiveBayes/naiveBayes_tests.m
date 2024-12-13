P% NAIVE BAYES TESTS

% load the trained model
load('trainedNaiveBayes.mat');

% list of test passwords
test_passwords = {
    '123456', 'compromised';
    'password', 'compromised';
    '!.acGSp|jPkI', 'strong';
    'trustno1', 'compromised';
    'Unbr3akable3!', 'strong';
    };

true_positive = 0;
true_negative = 0;
false_positive = 0;
false_negative = 0;

disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')

% loop for each password of test_passwords
for i = 1:size(test_passwords, 1)
    
    test_password = test_passwords(i, 1);
    true_label = test_passwords{i, 2};

    allChars_test = strjoin(test_password, '');
    chars_test = unique(char(allChars_test));
    
    probs_compromised = zeros(length(chars_test), 1); 

    fprintf('Passowrd: %s \n', string(test_password))
    
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

        fprintf("P(%c | compromised) = %.6f\n", chars_test(j), prob)
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

        fprintf("P(%c | strong) = %.4f\n", chars_test(j), prob);
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


    if strcmp(predicted_label, 'compromised')
        disp('Your password is most likely compromised. Better change it!');
    else
        disp('Good job, you have a strong password. It is most likely not compromised.');
    end

    
    disp(' ')
    disp("--------------------------")
    disp(' ')
end

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