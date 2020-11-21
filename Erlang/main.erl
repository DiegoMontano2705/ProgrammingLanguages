-module(main).
-import(lists, [map/2, foldl/3, foldr/3]).
%-export([test/0, solve/2, solve/3, solveConcurrent/3]).
-export([start/0, solve/2, evaluate/2, rndSolution/1, getInstance/1, check/3,solveConcurrentAux/3, solveConcurrent/3, solveProcess/2]).
% Do not forget to include the full name and student ID of the team members.
% ============================================
% Name: José Alberto González Arteaga
% Student Id: A01038061
% Name: Diego Fernando Montaño Pérez
% Student Id: A01282875
% Name: Eugenio González Arteaga
% Student Id: A01282852
% ============================================

% Evaluation of solutions
%
% evaluate/2 Returns a tuple with the sum of the weights and profits of the items in the knapsack.
% This function must be implemented by using tail recursion, to avoid problems with large instances.
% ============================================
% Example:
% 	project:evaluate([true, false, false, false, true], {12, [{5, 10}, {4, 7}, {8, 1}, {3, 5}, {7, 10}]}).
% Returns {12, 20}, which means that, the cumulative weight of the items in the knapsack is 12 units,
% and its profit is 20 units.
% ============================================

%LstBoleans -> [HB | TB]
%weight -> (_ {weight, _})
%values (List)-> [HV|TV] -> HV = {5, 10}
%HV = {5, 10} = element(1, HV)=> 5
%HV = {5,10} =element(2, HV) => 10
%evaluate([HB|TB], {W, [ HV | TV]}) -> element(2, HV).

evaluateAux([], {_ , []}, TW, TVAL) -> {TW, TVAL};
evaluateAux([HB | TB], {W, [HV | TV]}, TW, TVAL) -> if
  (HB == true) and ((TW + element(1, HV)) =< W) -> evaluateAux(TB, {W, TV}, TW + element(1,HV), TVAL + element(2,HV));
  true -> evaluateAux(TB, {W, TV}, TW, TVAL)
end. 

evaluate(LSTB, {W, LSTV}) -> evaluateAux(LSTB, {W, LSTV}, 0, 0).


%start() -> 
	%io:format("=== evaluate ===~n"),
	%io:format("~p~n", [evaluate([true, false, false, false, true], {12, [{5, 10}, {4, 7}, {8, 1}, {3, 5}, {7, 10}]})]),
  %io:format("~p~n", [evaluate([], {12, []})]). 

% Generation of random solutions
%
% rndSolution/1 generates a random solution for instances of n items.
% ============================================
% Example:
% 	project:rndSolution(5).
% Returns a random solution for an instance with five items.
% ============================================

rndSolution(0) -> [];
rndSolution(N) -> rndSolutionAux(N, rand:uniform()). 

rndSolutionAux(N, X) -> if
  (X > 0.5) -> [true | rndSolution(N - 1)];
  true -> [false | rndSolution(N - 1)]
end.

%start() -> 
	%io:format("=== rndSolution ===~n"),
	%io:format("~p~n", [rndSolution(5)]). 


% Mutation of solutions
%
% mutate/2 mutates a solution with a given probability.
% ============================================
% Example:
% 	project:mutate([true, false, false, false, true], 0.1).
% Returns a new solution which is slightly different from the one given as argument (the elements
% are changed with a probability of 0.1).
% ============================================
mutate([], _) -> [];
mutate(SOL,PROB) -> mutateAux(SOL,rand:uniform(),PROB).

mutateAux([H|T],N,PROB) -> if
   (PROB >= N) and (H == true) -> [false|mutate(T,PROB)];
   (PROB >= N) and (H == false) -> [true|mutate(T,PROB)];
   true -> [H|mutate(T,PROB)]
  end.

%start() -> 
	%io:format("=== mutate ===~n"),
	%io:format("~p~n", [mutate([true, false, false, false, true], 0.1)]).

% Instances
%
% getInstance/1 returns an instance of the knapsack problem. 
% Each instance is defined by a tuple {Capacity, Items}, where Capacity is an integer with the
% knapsack capacity and Items is a list of items. In this list of items, each item is represented
% as a tuple {Weight, Profit}, where Weight indicates the weight of the item and Profit, its profit.
% ============================================
% Example:
% 	project:getInstance(ks300).
% Returns the instance with identifier ks300. 
% ============================================
getInstance(test) -> {12, [{5, 10}, {4, 7}, {8, 1}, {3, 5}, {7, 10}]};
getInstance(ks45) -> {58181, [{4990, 1945}, {1142, 321}, {7390, 2945}, {10372, 4136}, {3114, 1107}, {2744, 1022}, {3102, 1101}, {7280, 2890}, {112738, 47019}, {3960, 1530}, {8564, 3432}, {5630, 2165}, {4506, 1703}, {3112, 1106}, {1240, 370}, {2014, 657}, {2624, 962}, {3020, 1060}, {2310, 805}, {2078, 689}, {3926, 1513}, {9656, 3878}, {32708, 13504}, {4830, 1865}, {2034, 667}, {4766, 1833}, {40006, 16553}, {3422, 1261}, {6686, 2593}, {3240, 1170}, {2288, 794}, {2042, 671}, {18142, 7421}, {14718, 6009}, {4634, 1767}, {6744, 2622}, {2362, 831}, {2102, 701}, {12944, 5222}, {7872, 3086}, {2500, 900}, {7942, 3121}, {2958, 1029}, {126010, 52555}, {1278, 389}]}.


% Sequential solver 
%
% solve/2 solves an instance by testing n different solutions.
% ============================================
% Example:
% 	project:solve(knapsack:getInstance(ks45), 1000000).
% Tries a million of solutions for instance with identifier ks45 and returns a tuple of three
% elements {Solution, Weight, Profit}, where Solution contains the actual solution found and
% Weight and Profit indicate the total weight and profit packed within the knapsack, respectively.
% ============================================
%getInstance(test) -> {12, [{5, 10}, {4, 7}, {8, 1}, {3, 5}, {7, 10}]};

% solve({Hinstance, Tinstance}, N) -> 
  %Solution = rndSolution(length(Tinstance)),
  %Solutioneva = evaluate(Solution, {Hinstance, Tinstance}),
  %  if 
  %  N > 0 -> Candidate = mutate(Solution, 0.1),
  %  Candidateeva = evaluate(Candidate, {Hinstance, Tinstance}),    
  %    if 
  %      tl (Candidateeva) > tl (Solutioneva) -> solve({Candidate, Candidateeva}, N - 1);
  %      true -> solve({Solution, Solutioneva}, N - 1)
  %    end;         
  %  true -> [Tinstance ++ Solutioneva]
  %end.
%Instance => {58181, [{xn, yn},...]
%N => Iterations
%Solution => 
solveAux(Solution, SolutionEval, Instance, N) ->
  if N > 0 ->
  Candidate = mutate(Solution, 0.5),
  CandidateEval = evaluate(Candidate, Instance),
    if element(2, CandidateEval) > element(2, SolutionEval) ->
      solveAux(Candidate, CandidateEval, Instance, N - 1);
      true -> solveAux(Solution, SolutionEval, Instance, N-1)
    end;
  true -> {Solution, element(1, SolutionEval), element(2, SolutionEval)}
end.

solve(Instance, N) -> 
    Capacity = element(1, Instance),
    Elements = element(2, Instance), 
		Solution = rndSolution(length(Elements)),
		SolutionEval = evaluate(Solution, { Capacity, Elements } ),
		solveAux(Solution, SolutionEval, Instance, N).

%start() -> 
	%io:format("=== solve/2 ===~n"),
	%io:format("~p~n", [solve(getInstance(test), 100)]).

% Concurrent solver 
%
% solveConcurrent/3 solves an instance by testing n different solutions on m different processes.
% ============================================
% Example:
% 	project:solveConcurrent(knapsack:getInstance(ks45), 1000000, 4).
% Tries a million of solutions for instance with identifier ks45 by splitting the work into
% four concurrent processes and returns a tuple of three elements {Solution, Weight, Profit},
% where Solution contains the actual solution found and Weight and Profit indicate the total
% weight and profit packed within the knapsack, respectively.
% ============================================


%----------------------------------------

solveConcurrentAux(_,_,0) -> ok;
solveConcurrentAux(Instance,N,M) ->
  spawn(main,solveProcess, [Instance, N]),
  solveConcurrentAux(Instance, N, M-1).

solveProcess(Instance, N) -> Result = solve(Instance, N),
reg ! Result.

check(Id,0,S) -> Id ! S;
check(Id,N,S) ->
  receive
    S2 ->
      if 
        element(3,S2) > element(3,S) -> check(Id,N-1,S2);
        true -> check(Id,N-1, S)
      end
  end.

solveConcurrent(Instance,N,M) ->
  Pid = spawn(main,check,[self(),M,{[],0,0}]),
  register(reg,Pid),
  solveConcurrentAux(Instance, floor(N/M), M),
  receive
    Result -> Result
  end. 



%start() -> 
	%io:format("=== solveConcurrent/3 ===~n"),
	%io:format("~p~n", [solveConcurrent(getInstance(ks45), 100000,4)]).

% === Test cases (internal use) ===
% Use this code to test if your codes are working as expected. 

%Correct implementation
%start() ->
	%io:format("~p~n", [evaluate([true, false, false, false, true], {12, [{5, 10}, {4, 7}, {8, 1}, {3, 5}, {7, 10}]})]), % {12,20}
	%io:format("~p~n", [evaluate([false, false, true], {7, [{1, 10}, {4, 3}, {12, 2}]})]), % {0,0}
	%io:format("~p~n", [evaluate([true, true, true], {10, [{1, 10}, {10, 13}, {4, 2}]})]), % {5,12}
	%io:format("~p~n", [mutate([true, true, true], 1)]), % [false,false,false]
	%io:format("~p~n", [mutate([true, true, true], 0)]). % [true,true,true]

% === Evaluation ===
%
% solve/3 evaluates the running time of the solvers on specific instances. If properly implemented,
% the concurrent solver should be faster than the sequential. However, the quality of the solutions
% should be similar for both solvers.
% ============================================
% Example:
% 	project:solve(ks1000, 100000, 4).
% Solves the instance with identifier ks1000 by using (1) the sequential solver with 100000 solutions 
% and (2) the concurrent solver with also 100000 solutions and four processors. Please be aware that
% this test may take some time to finish.

solve(Name, Solutions, Processors) ->	
	Instance = getInstance(Name),	
	{T1, {_, _, P1}} = timer:tc(main, solve, [Instance, Solutions]),		
	io:format("Instance: ~p.~n", [Name]),
	io:format("Sequential approach): ~p seconds (profit = ~p).~n", [T1 / 1000000, P1]),	
	{T2, {_, _, P2}} = timer:tc(main, solveConcurrent, [Instance, Solutions, Processors]),		
	io:format("Concurrent approach): ~p seconds (profit = ~p).~n", [T2 / 1000000, P2]),
	ok.

start() -> 
	io:format("=== Project ===~n"),
	io:format("~p~n", [solve(ks45, 10000, 4)]),
  io:format("~p~n", [solve(ks45, 10000, 4)]),
  io:format("~p~n", [solve(ks45, 10000, 4)]).
