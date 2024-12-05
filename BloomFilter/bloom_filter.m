% BLOOM FILTER CONFIGURATION

% upload the file that contains the most common passwords
fileID = fopen('common_passwords.txt', 'r');  % Abre o arquivo para leitura
common_passwords = textscan(fileID, '%s');  % Lê todas as senhas como células de strings
fclose(fileID);  % Fecha o arquivo
common_passwords = common_passwords{1};

% parameters for the Bloom Filter
n = 100000;
k = 10;

% inicialization of the Bloom Filter
BloomFilter = init_filter(n);

for i = 1:length(common_passwords)
    
    BloomFilter = add_element(BloomFilter, common_passwords{i}, k);

end


% test
test_password1 = 'bana$ajshd23';
test_password2 = 'monkey';

result1 = is_in_BloomFilter(BloomFilter, test_password1, k);
disp(['Result for password 1 (', test_password1, '): ', num2str(result1)]);

if result1 
    disp('Compromised!');
else
    disp('No compromised!');
end

disp(' ');

result2 = is_in_BloomFilter(BloomFilter, test_password2, k);
disp(['Result for password 2 (', test_password2, '): ', num2str(result2)]);

if result2
    disp('Compromised!');
else
    disp('Not compromised!');
end


