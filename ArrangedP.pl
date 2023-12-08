% Base case to stop the recursion
b(B, N, L) :-
    N > L,
    write('Number of Blue disks: '), write(B), nl,
    !.  % Cut to prevent backtracking

% Recursive case to calculate the next values
b(B, N, L) :-
    N =< L,
    NewB is 3*B + 2*N - 2,
    NewN is 4*B + 3*N - 3,
    b(NewB, NewN, L).

% Start the process with initial values for B and N, and a limit L
start(B, N, L) :-
    b(B, N, L).

% swipl -s ArrangedP.pl -g "start(85, 120, 1000000000000), halt."