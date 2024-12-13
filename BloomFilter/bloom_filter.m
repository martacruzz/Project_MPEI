% BLOOM FILTER CONFIGURATION

% upload the file that contains the most common passwords
fileID = fopen('common_passwords.txt', 'r');  
common_passwords = textscan(fileID, '%s');  
fclose(fileID);  
common_passwords = common_passwords{1};

% parameters for the Bloom Filter
n = 100000;
k = 10;

% inicialization of the Bloom Filter
BloomFilter = init_filter(n);

for i = 1:length(common_passwords) 
    BloomFilter = add_element(BloomFilter, common_passwords{i}, k);
end


save('BloomFilter.mat', 'BloomFilter', 'n', 'k');
