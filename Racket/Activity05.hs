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

-- === index ===

index :: [Char] -> Char -> Int
index [] x = error "Character not found"
index lst x = if (head lst) == x
  then 0
  else 1 + index (tail lst) x

-- === first ===

firstn :: [t] -> Int -> [t]
firstn [] x = []
firstn lst 0 = []
firstn lst n = (head lst) : (firstn (tail lst) (n-1))

-- === last ===

lastn :: [t] -> Int -> [t]
lastn lst n = if n >= (length lst)
  then lst
  else lastn (tail lst) n

-- === Test cases ===

main = do 
    print "=== index ==="
    print $ index "abcdefgh" 'a' -- 0
    print $ index "abcdefgh" 'e' -- 4    
    print "=== firstn ==="
    print $ firstn "abcdefgh" 3 -- "abc"
    print $ firstn [1.1, 2.2, 3.3, 4.4, 5.5] 2 -- [1.1,2.2]
    print $ firstn [10, 20, 30, 40, 50] 6 -- [10,20,30,40,50]
    print "=== lastn ==="
    print $ lastn "abcdefgh" 3 -- "fgh"
    print $ lastn  [1.1, 2.2, 3.3, 4.4, 5.5] 2 -- [4.4,5.5]
    print $ lastn  [10, 20, 30, 40, 50] 6 -- [10,20,30,40,50]      