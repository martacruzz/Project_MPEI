function bloom_filter_tests (BloomFilter, k)
    
    disp('------ STARTING BLOOM FILTER TESTS ------');

    test_passwords = {
        '123456';
        'banana';
        '!,~zMu]"+:|m';
        'unknown123';
        'paris';
        'abcdefg';
    };

    for i = 1:length(test_passwords)
        
        password = test_passwords{i};
        result = is_in_BloomFilter(BloomFilter, password, k);

        disp(['Result for password (', password, '): ', num2str(result)]);

        if result
            disp('Compromised!');
        else
            disp('Not compromised!');
        end
        
        disp(' ');

    end

    disp('------ TESTS COMPLETED ------')
end