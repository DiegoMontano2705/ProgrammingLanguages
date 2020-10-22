-- Diego Montaño Pérez A01282875
-- ====================
-- Complete the following functions and submit your file to Canvas.
-- ====================
-- Do not change the names of the functions. 
-- Do not change the number of arguments in the functions.
-- If your file cannot be loaded by the Haskell compiler, your submission may be cancelled. 
-- Then, submit only code that works.
-- ====================
-- Grading instructions:
-- There is a series of test cases for each function. In order to state that your function
-- "works as described", your output must be similar to the expected one in each case.

-- === distance ===
distance :: (Double, Double) -> (Double, Double) -> Double
distance d1 d2 = sqrt ( (((fst d1) - (fst d2)) ^^ 2) +  (((snd d1) - (snd d2)) ^^ 2))

-- === shift ===

shift :: [t] -> Int -> [t]
shift lst 0 = lst
shift lst n = if n > 0
  then shift ((last lst) : (init lst)) (n - 1)
  else shift ((tail lst) ++ [head lst]) (n + 1)

-- === myFilter ===

-- Please note that this function takes two arguments.
-- The first one is a function of type (t -> Bool)
-- The second one is a list of a generic type, t.
myFilter :: (t -> Bool) -> [t] -> [t]
myFilter op [] = []
myFilter op lst = if op (head lst)
  then [head lst] ++ myFilter op (tail lst)
  else myFilter op (tail lst) 

-- === crossover ===

crossover :: [Char] -> [Char] -> Int -> ([Char], [Char])
crossover [] [] x = ([],[])
crossover (i:f) (i2:f2) x = if x == 1
  then (i:f2 , i2: f)
  else let (a,b) = crossover f f2 (x- 1)
   in
    (i:a, i2:b) 

-- === xSort ===

xSort :: [(String, Int, Int)] -> [(String, Int, Int)]
xSort [] = []
xSort ((fTeam, fPoints, fGoals):rest) = let 
    leftList = filter (\(team, points, goals) -> if (points == fPoints) then (goals >= fGoals) else (points > fPoints)) rest
    rightList = filter (\(team, points, goals) -> if (points == fPoints) then (goals < fGoals) else (points < fPoints)) rest
    in
    (xSort leftList) ++ [(fTeam, fPoints, fGoals)] ++ (xSort rightList)

--xSort :: [(String, Int, Int)] -> [(String, Int, Int)]
--xSort table = xSortAux x table
--xSort _ = error "Not yet implemented\n"
-- === treeSum ===

data Tree = Tree Int Tree Tree | E deriving Show

treeSum :: Tree -> Int
treeSum (E) = 0
treeSum (Tree x left right) = (treeSum left) + x + (treeSum right) 
-- === Test cases ===

main = do
    print "=== distance ==="
    print $ distance (10, 20) (5, 15) -- 7.0710678118654755
    print "=== shift ==="
    print $ shift [3, 5, 1, 4, 2] 3 -- [1,4,2,3,5]
    print $ shift [3, 5, 1, 4, 2] (-3) -- [4,2,3,5,1]
    print $ shift "helloworld" 75 -- "worldhello"
    print "=== myFilter ==="
    print $ myFilter (> 3) [1, 2, 3, 4, 5, 6, 7] -- [4,5,6,7]
    print $ myFilter (\x -> x * 2 < 5) [1, 2, 3, 4, 5, 6, 7] -- [1,2]
    print "=== crossover ==="
    print $ crossover "aaaaa" "bbbbb" 3 -- ("aaabb","bbbaa")
    print $ crossover "aaaaa" "bbbbb" 1 -- ("abbbb","baaaa")
    print $ crossover "aaaaa" "bbbbb" 4 -- ("aaaab","bbbba")
    print "=== qSort ==="
    print $ xSort [("Pumas", 10, 3), ("America", 10, 5), ("Chivas", 11, 8), ("Cruz Azul", 11, 2), ("Tigres", 9, 4), ("Rayados", 9, 6)] -- [("Chivas",11,8),("Cruz Azul",11,2),("America",10,5),("Pumas",10,3),("Rayados",9,6),("Tigres",9,4)]
    print "=== treeSum ==="
    print $ treeSum (Tree 8 (Tree 5 (Tree 2 E E) (Tree 7 E E)) (Tree 9 E E))