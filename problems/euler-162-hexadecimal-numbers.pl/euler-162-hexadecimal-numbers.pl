% Predicate to calculate the sum of a special sequence up to a given Limit
s(Limit) :-
    findall(X, (
        between(3, Limit, N),
        X is 15*16**(N-1) + 41*14**(N-1) - (43*15**(N-1) + 13**N)
    ), Xs),
    sum_list(Xs, Sum),
    Solution is integer(Sum),
    format(' ~`0t~16R~2n', [Solution]).

% Directive to run the main predicate after the program is initialized
:- initialization(main, main).

% Main predicate to parse command line arguments and execute the solution
main :-
    current_prolog_flag(argv, Argv),
    (   append(_, [Limit | _], Argv),
        atom_number(Limit, L),
        s(L)
    ;   write('Usage: script Limit'),
        nl,
        halt(1)
    ).
