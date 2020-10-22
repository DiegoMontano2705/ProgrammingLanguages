-- Diego Fernando Montaño Pérez A01282875
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

-- === invert ===

invert :: [t] -> [t]
invert [] = []
invert lst = (last lst) : (invert (init lst)) 

-- === or ===

listor :: [Int] -> [Int] -> [Int]
listor [] [] = []
listor lstA lstB = if (head lstA == 1) || (head lstB == 1) == True
  then (1) : (listor (tail lstA) (tail lstB))
  else (0) : (listor (tail lstA) (tail lstB))

-- === multiples ===

multiples :: [Int] -> Int -> [Int]
multiples [] x = []
multiples lst x = if ((head lst) `rem` x) == 0
  then (head lst) : (multiples (tail lst) x)
  else multiples (tail lst) x
--multiples _ _ = error "Not yet implemented\n"

-- === differences ===

differencesAux :: [Int] -> Int -> [Int]
differencesAux lst x = if (tail lst) == []
  then [abs ( (head lst) - x)]
  else (abs ( (head lst) - (head (tail lst)))) : (differencesAux (tail lst) x)

differences :: [Int] -> [Int]
differences [] = []
differences lst = differencesAux lst (head lst)

-- === toBinaryString ===

toBinaryStringAux :: Int -> [Char]
toBinaryStringAux 0 = []
toBinaryStringAux x = if (x `mod` 2) == 0
  then "0" ++ (toBinaryStringAux (x `quot` 2))
  else "1" ++ (toBinaryStringAux (x `quot` 2))

toBinaryString :: Int -> [Char]
toBinaryString x = if x == 0
  then "0"
  else (reverse (toBinaryStringAux x))

-- === modulo ===

modulo :: Int -> Int -> Int
modulo x y = if x < y
  then x
  else modulo (x-y) y

-- === evaluate ===

evaluateAux :: [Double] -> Double -> Int -> Double
evaluateAux [] x n = 0
evaluateAux coef x n = ((head coef) * (x ^^ n)) + (evaluateAux (tail coef) x (n-1))

evaluate :: [Double] -> Double -> Double
evaluate [] x = 0
evaluate coef x = (evaluateAux coef x ((length coef) - 1))


-- === cleanString ===

cleanStringAux :: [Char] -> Char -> [Char]
cleanStringAux [] c = []
cleanStringAux str c = if (head str) == c 
  then (cleanStringAux (tail str) (head str))
  else [head str] ++ (cleanStringAux (tail str) (head str))
 
cleanString :: [Char] -> [Char]
cleanString [] = []
cleanString str = [head str] ++ (cleanStringAux (tail str) (head str))


-- === iSort ===

iSortAux :: Int -> [Int] -> [Int]
iSortAux x [] = [x]
iSortAux x (ini:fin) = if x < ini
  then x:ini:fin 
  else ini: iSortAux x fin

iSort :: [Int] -> [Int]
iSort [] = []
iSort (lstI:lstE) = iSortAux lstI (iSort lstE)

-- === Test cases ===

main = do 
    print "=== invert ==="
    print $ invert ([] :: [Int])-- []
    print $ invert [1, 2, 3, 4, 5] -- [5,4,3,2,1]
    print $ invert "hello world!" -- "!dlrow olleh"
    print "=== listor ==="
    print $ listor [1, 1, 0] [0, 1, 0] -- [1,1,0]
    print $ listor [1, 0, 1, 0] [0, 0, 1, 1] -- [1,0,1,1]
    print $ listor [1, 0, 1, 0, 1] [1, 1, 1, 0, 0] -- [1,1,1,0,1]
    print "=== multiples ==="
    print $ multiples [2, 4, 5, 6] 2 -- [2,4,6]
    print $ multiples [9, 27, 8, 15, 4] 3 -- [9,27,15]
    print $ multiples [9, 8, 17, 5] 6 -- []
    print "=== differences ==="
    print $ differences [1, 2, 4, 8, 20] -- [1,2,4,12,19]
    print $ differences [5, 9, 13, 27, 100, 91, 4] -- [4,4,14,73,9,87,1]
    print $ differences [99] -- [0]
    print $ differences [] -- [] 
    print "=== toBinaryString ==="
    print $ toBinaryString 0 -- "0"
    print $ toBinaryString 1 -- "1"
    print $ toBinaryString 7 -- "111"
    print $ toBinaryString 32 -- "100000"
    print $ toBinaryString 1024 -- "10000000000"
    print "=== modulo ==="
    print $ modulo 10 2 -- 0
    print $ modulo 15 4 -- 3
    print $ modulo 20 9 -- 2
    print $ modulo 77 10 -- 7
    print "=== evaluate ==="
    print $ evaluate ([] :: [Double]) 100 -- 0.0
    print $ evaluate [2, 3.1, 10, 0] 2 -- 48.4
    print $ evaluate [10, 0] 2 -- 20.0
    print $ evaluate [1, 2, 3, 4, 5] 3 -- 179.0
    print "=== cleanString ==="
    print $ cleanString ([] :: String) -- ""
    print $ cleanString "yyzzza" -- "yza"
    print $ cleanString "aaaabbbccd" -- "abcd"
    print "=== iSort ==="
    print $ iSort [] -- []
    print $ iSort [1] -- [1]
    print $ iSort [1, 6, 3, 10, 2, 14] -- [1,2,3,6,10,14]