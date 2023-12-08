% problem1/2 takes an input N and returns the Answer
problem1(N, Answer) :- 
    N1 is N - 1, % Calculate N - 1
    findall(X, (between(1, N1, X), check(X)), L), % Find all numbers between 1 and N - 1 that satisfy the check
    sumlist(L, Answer). % Sum the list of numbers and unify it with Answer

% check/1 checks if a number is divisible by 3 or 5
check(N) :- N rem 3 =:= 0, !. % If N is divisible by 3, cut and succeed
check(N) :- N rem 5 =:= 0. % If N is divisible by 5, succeed
