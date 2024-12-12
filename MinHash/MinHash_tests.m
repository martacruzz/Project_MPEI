% MINHASH TESTS

% load the trained model
load("MinHashSignatures.mat");

% configuration of the test parameters
threshold = 0.5;   % similarity threshold to consider similar passwords

% list of test passwords
test_passwords = {
    '123456', ['123456'];
    '!.acGSp|jPkI', [];
    'trustno1', [];
    'password', ['passoword'];
    'Unbr3akable3!', [];
};


disp(' ')
disp('------------------ STARTING TESTS ------------------');
disp(' ')


% loop of each password of test_passwords
for i = 1:size(test_passwords, 1)
    
    inputPassword = test_passwords{i, 1};
    expected_similars = test_passwords{i, 2};

    inputSignature = GetSignatures(inputPasword, k, shingleSize);
    [similarities, similars] = GetSimilarities(compromised, compromisedSignatures, inputSignature, threshold, k);

    fprintf("Password: %s \n", inputPassword);


   
    if ~isempty(similars)
        
        fprintf("Similar passwords found: \n");

        for j = 1:length(similars)
            fprintf('%2d. %s\n', j, similars{j})        
        end

    
    else
        fprintf('No similar password found! \n');

    end

    disp(' ');
end


disp(' ')
disp('------ TESTS COMPLETED ------')