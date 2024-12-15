% BLOOM FILTER TESTS

% load the trained model and the scripts with the passwords
load('BloomFilter.mat');

common_passwords = readlines('common_passwords.txt');
strong_passwords = readlines('strong_passwords.txt');

% select 5% of each group
num_common = round(length(common_passwords) * 0.05);
num_strong = round(length(strong_passwords) * 0.05);

common_sample = datasample(common_passwords, num_common, 'Replace', false);
strong_sample = datasample(strong_passwords, num_strong, 'Replace', false);

% add passwords that don't belong to any group
external_passwords = {'TotallyNew#Pass'; 'Unkown@Password'; 'NotInList123'};

% combine the three samples to the test
test_passwords = [common_sample; strong_sample; external_passwords];


true_positive = 0;
true_negative = 0;
false_positive = 0;
false_negative = 0;

disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')

% loop for each password
for i = 1:length(test_passwords)
    test_password = test_passwords{i};
    
    % check if the password is in the Bloom Filter
    is_compromised = is_in_BloomFilter(BloomFilter, test_password, k);

    fprintf('Password: %s  ->  ', test_password);
    
    if ismember(test_password, common_passwords)
        true_label = 'compromised';
    else
        true_label = 'strong';
    end


    if is_compromised
        fprintf('compromised');
    else
        fprintf('no compromised');
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
