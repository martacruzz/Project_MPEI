% MINHASH TESTS

% load the trained model and the scripts with the passwords
load("MinHashSignatures.mat");

common_passwords = string(readlines('common_passwords.txt'));
strong_passwords = string(readlines('strong_passwords.txt'));

% configuration of the test parameters
threshold = 0.5;   % similarity threshold to consider similar passwords
k = 200;           % Number of hash functions
shingleSize = 3;   % Shingles size

% select 5% of each group
num_common = round(length(common_passwords) * 0.05);
num_strong = round(length(strong_passwords) * 0.05);

common_sample = common_passwords(randperm(length(common_passwords), num_common));
strong_sample = strong_passwords(randperm(length(strong_passwords), num_strong));

% add passwords that don't belong to any group
external_passwords = ["TotallyNew#Pass"; "Unkown@Password"; "NotInList123"];

% combine the three samples to the test
test_passwords = [common_sample; strong_sample; external_passwords];


disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')


% loop of each password of test_passwords
for i = 1:length(test_passwords)
    
    inputPassword = string(test_passwords{i});
    inputSignature = GetSignatures(inputPassword, k, shingleSize);

    [similarities, similars] = GetSimilarities(compromised, compromisedSignatures, inputSignature, threshold, k);

    fprintf("Password: %s -> ", inputPassword);


   
    if ~isempty(similars)
        
        fprintf("Similar passwords found");

       % for j = 1:length(similars)
        %    fprintf('%2d. %s\n', j, similars{j})        
        %end

    
    else
        fprintf('No similar password found');

    end

    disp(' ');
end


disp(' ')
disp('------ TESTS COMPLETED ------')
