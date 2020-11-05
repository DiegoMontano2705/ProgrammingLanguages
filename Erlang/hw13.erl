%Diego Montaño A01282875
-module(hw13).
-import(lists, [map/2, filter/2, zip/2]). % To avoid uning "lists:" on every function call.
-export([start/0]).

% ====================
% Complete the following functions and submit your file to Canvas.
% ====================
% Do not change the names of the functions. 
% Do not change the number of arguments in the functions.
% If your file cannot be loaded by the Erlang compiler, your submission may be cancelled. 
% Then, submit only code that works.
% ====================
% Grading instructions:
% There is a series of test cases for each function. In order to state that your function
% "works as described", your output must be similar to the expected one in each case.

% === index ===

index(_, []) -> "Element not in the list";
index(N,[H|T]) ->  if 
  H == N -> 0;
  H /= N -> 1 + index(N,T)
  end. 

% === firstn ===
firstn([],_) -> [];
firstn(LST,0) -> [];
firstn([H|T], N) -> [H] ++ firstn(T,(N-1)). 
% === lastn ===
lastn (LST,0 ) -> LST;
lastn([H|T], N) -> lastn(T,(N-1)).  

  
% === sum ===

sum([]) -> 0;
sum([H|T]) -> sum(H)  + sum(T); 
sum(N) -> N.
% === even ===

even(LST) -> filter(fun(X) -> (X rem 2 ) == 0 end,LST). 

% === reverse ===

reverse([]) -> [];
reverse([H|T]) -> if
 is_list(H) == false  -> reverse(T) ++ [H];
 is_list(H) == true -> reverse(T) ++ [reverse(H)]
 end. 


% === maskedSum ===
maskedSum([],[]) -> 0;
maskedSum([H|T], [H2|T2]) -> if
  H2 == true -> H + maskedSum(T,T2);
  H2 == false -> maskedSum(T,T2)
  end. 

% === evaluate ===

evaluateAux([], X, N) -> 0;
evaluateAux([H|T], X, N) -> (H * math:pow(X,N)) + evaluateAux(T,X,N-1). 

evaluate([],_) -> 0;
evaluate(COEF, X) -> evaluateAux(COEF,X, length(COEF)-1). 

% === Test cases ===

start() -> 
	io:format("=== index ===~n"),
	io:format("~p~n", [index(5, [1, 2, 3, 4, 5])]), % 4
	io:format("~p~n", [index([3, 4], [[1, 2], [3, 4], [5, 6]])]), % 1
	io:format("~p~n", [index('c', ['a', 'b', 'c', 'd', 'e'])]), % 2
	io:format("=== firstn ===~n"),
	io:format("~p~n", [firstn([10, 20, 30, 40, 50], 3)]), % [10,20,30]
	io:format("~p~n", [firstn([10, 20, 30, 40, 50], 5)]), % [10,20,30,40,50]
	io:format("=== lastn ===~n"),
	io:format("~p~n", [lastn(['a', 'b', 'c', 'd', 'e'], 3)]), % [d,e]
	io:format("~p~n", [lastn([10, 20, 30, 40, 50], 5)]), % []
	io:format("=== sum ===~n"),
	io:format("~p~n", [sum([10, 20, 30, 40, 50])]), % 150
	io:format("~p~n", [sum([[20, [], []], 3])]), % 23
	io:format("~p~n", [sum([15, [5, 4, [3, 10], 6, [8]]])]), % 51
	io:format("=== even ===~n"),
	io:format("~p~n", [even([1, 2, 3, 4, 5, 6, 7, 8, 9])]), % [2,4,6,8]
	io:format("~p~n", [even([33, 45, 18, 17, 25, 62, 100])]), % [18,62,100]
	io:format("=== reverse ===~n"),
	io:format("~p~n", [reverse([33, 45, 18, 17, 25, 62, 100])]), % [100,62,25,17,18,45,33]
	io:format("~p~n", [reverse([15, [5, 4, [3, 10], 6, [80, 17]]])]), % [[[17,80],6,[10,3],4,5],15]
	io:format("=== maskedSum ===~n"),
	io:format("~p~n", [maskedSum([10, 20, 30, 40, 50], [true, true, false, false, true])]), % 80
	io:format("~p~n", [maskedSum([10, 20, 30, 40, 50], [false, true, false, false, false])]), % 20
	io:format("=== evaluate ===~n"),
	io:format("~p~n", [evaluate([], 10)]), % 0
	io:format("~p~n", [evaluate([2, 3.1, 10, 0], 2)]), % 48.4
	io:format("~p~n", [evaluate([10, 0], 2)]), % 20.0
	io:format("~p~n", [evaluate([1, 2, 3, 4, 5], 3)]). % 179.0