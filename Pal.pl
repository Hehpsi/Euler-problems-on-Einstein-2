% Predicate to check if a number is a palindrome
is_palindrome(X) :-
    number_chars(X, XChars),  % Convert the number to a list of characters
    reverse(XChars, XChars).  % Check if the list of characters is the same when reversed

% Predicate to find the largest palindrome product of two N-digit numbers
largest_palindrome_product(N, X) :-
    Max is 10^N - 1, 
    Min is 10^(N-1),  
    % Find all products of two N-digit numbers that are palindromes
    findall(Res, (
        between(Min, Max, A),  
        between(Min, Max, B),  
        Res is A * B,         
        is_palindrome(Res)     
    ), List),
    max_list(List, X).

% swipl -s Pal.pl -g "largest_palindrome_product(3, X), writeln(X), halt."