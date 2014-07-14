%% Pirate gold

pirateGold(NumPirates, Gold, Division) :-
	pirateGold_(NumPirates, Gold, Division), !.
%	!,
%	nth1(NumPirates, Division, Split),
%	not(betterSplit(NumPirates, Gold, Split)).

betterSplit(NumPirates, Gold, Split) :-
	Rest is Gold - Split,
	Rest > 0,
	NumPirates1 is NumPirates - 1,
	list_with_sum2(Rest, NumPirates1, List),
	append(List, [Split], Division1),
%%%->	pirateGold_(NumPirates, Gold, Division1),
	nth1(NumPirates, Division1, Split1),
	Split1 > Split.

pirateGold_(1, Gold, [Gold]) :- !.

pirateGold_(NumPirates, Gold, Division) :-
	NumPirates1 is NumPirates - 1,
	pirateGold(NumPirates1, Gold, Division1), !,
	list_with_sum2(Gold, NumPirates, Division),
	votes(1, NumPirates, Gold, Division, Division1, Count),
	Minimum is NumPirates / 2,
	Count >= Minimum.

votes(Rank, Rank, _, _, _, 1) :- !.

votes(Rank, NumPirates, Gold, Division, Division1, Count) :-
	vote(Rank, NumPirates, Gold, Division, Division1, Vote),
	Rank1 is Rank + 1,
	votes(Rank1, NumPirates, Gold, Division, Division1, Count1),
	Count is Vote + Count1.

vote(Rank, _, _, Division, Division1, 0) :-
	nth1(Rank, Division, Split),
	nth1(Rank, Division1, Split1),
	Split1 >= Split,
	!.

vote(_, _, _, _, _, 1).

list_with_sum2(Sum, 1, [Sum]) :- !.
list_with_sum2(Sum, Length, List) :-
	NegativeSum is 0 - Sum,
	between(NegativeSum, 0, N),
	abs(N, Split),
	Rest is Sum - Split,
	Length1 is Length - 1,
	list_with_sum2(Rest, Length1, L),
	append(L, [Split], List).


range(Low, Low, [Low]) :- !.

range(Low, High, [Low|Out]) :-
	NewLow is Low + 1,
	range(NewLow, High, Out).

list_with_sum(Sum, 1, [Sum]).

list_with_sum(Sum, Length, [X|List]) :-
	between(0, Sum, X),
	Rest is Sum - X,
	NewLength is Length - 1,
	length(List, NewLength),
	list_with_sum(Rest, NewLength, List).








