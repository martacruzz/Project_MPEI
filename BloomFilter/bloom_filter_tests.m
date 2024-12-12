% BLOOM FILTER TESTS

% load the trained model
load('BloomFilter_model.mat');

% list of test passwords
test_passwords = {
    '123456', 'compromised';
    'banana', 'compromised';
    '!,~zMu]"+:|m', 'strong';
    'unknown123', 'strong';
    'paris', 'compromised';
    };

true_positive = 0;
true_negative = 0;
false_positive = 0;
false_negative = 0;

disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')

% loop for each password
for i = 1:size(test_passwords, 1)
    test_password = test_passwords{i, 1};
    true_label = test_passwords{i, 2};
    
    % check if the password is in the Bloom Filter
    is_compromised = is_in_BloomFilter(BloomFilter, test_password, k);

    fprintf('Password: %s\n', test_password);

    if is_compromised
        fprintf('Result: Compromised \n');
    else
        fprintf('Resultado: No compromised \n');
    end


    if is_compromised && strcmp(true_label, 'compromised')
        true_positive = true_positive + 1;

    elseif ~is_compromised && strcmp(true_label, 'strong')
        true_negative = true_negative + 1;

    elseif is_compromised && strcmp(true_label, 'strong')
        false_positive = false_positive + 1;

    elseif ~is_compromised && strcmp(true_label, 'compromised')
        false_negative = false_negative + 1;
    end

    disp(' ');
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
