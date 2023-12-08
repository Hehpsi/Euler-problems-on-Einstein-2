import System.Environment
-- Conversion Stuff(avoiding GHC dependencies)
isCharNum :: Char -> Bool
isCharNum c = elem c "0123456789"

isNum :: String -> Bool
isNum [lc] = isCharNum lc
isNum (sh:st) = if isCharNum sh then isNum st else False

charToInt :: Char -> Int
charToInt '0' = 0
charToInt '1' = 1
charToInt '2' = 2
charToInt '3' = 3
charToInt '4' = 4
charToInt '5' = 5
charToInt '6' = 6
charToInt '7' = 7
charToInt '8' = 8
charToInt '9' = 9

get10Exp :: Int -> Int
get10Exp 0 = 1
get10Exp x = 10 * get10Exp (x - 1)

toInt :: String -> Int
toInt [lc] = charToInt lc 
toInt (sh:st) = (get10Exp(length st) * charToInt sh) + toInt st

-- Main
main = do
    (p1:_) <- getArgs
    if isNum p1
        then 
           let num = toInt p1
           in putStrLn (eulerSolution num)
    else putStrLn "Invalid Input"



-- Solution
eulerSolution :: Int -> String
eulerSolution n = convertToHex$reverse$mediator n 

mediator :: Int -> [Int]
mediator 0 = [0]
mediator n = addWithSign (calcHexes n) (mediator (n - 1))


calcHexes :: Int -> [Int]
calcHexes n = let lhs = subtractWithSign (expr1 n) (expr2 n)
                  rhs = subtractWithSign (expr3 n) (expr4 n)
              in addWithSign lhs rhs
-- calcHexes :: Int -> Int
-- calcHexes n = expr1 n - expr2 n + expr3 n - expr4 n

expr1 n = let b16 = intToHexList 16
              b15 = intToHexList 15
          in multList b15 (hexPow b16 (n - 1))

expr2 n = let b43 = intToHexList 43
              b15 = intToHexList 15
          in multList b43 (hexPow b15 (n - 1))

expr3 n = let b41 = intToHexList 41
              b14 = intToHexList 14
          in multList b41 (hexPow b14 (n - 1))

expr4 n = hexPow (intToHexList 13) n 

-- expr1 n = 15 * (intPow 16 (n - 1))
-- expr2 n = 43 * (intPow 15 (n - 1))
-- expr3 n = 41 * (intPow 14 (n - 1))
-- expr4 n = intPow 13 n 



-- HEX Quality of life
convertToHex :: [Int] -> String
convertToHex [] = [] 
convertToHex (h:t) = [hexMap h] ++ convertToHex t

hexMap :: Int -> Char
hexMap 0  = '0'
hexMap 1  = '1'
hexMap 2  = '2'
hexMap 3  = '3'
hexMap 4  = '4'
hexMap 5  = '5'
hexMap 6  = '6'
hexMap 7  = '7'
hexMap 8  = '8'
hexMap 9  = '9'
hexMap 10 = 'A'
hexMap 11 = 'B'
hexMap 12 = 'C'
hexMap 13 = 'D'
hexMap 14 = 'E'
hexMap 15 = 'F'
hexMap x  = '-'

hexPow :: [Int] -> Int -> [Int]
hexPow a 0 = [1]
hexPow a n = multList (hexPow a (n - 1)) a


-- HEX arbitrary precision arithmetic
intToHexList :: Int -> [Int]
intToHexList 0 = []
intToHexList n =
    let remainder = div n 16
        digit     = mod n 16
    in [digit] ++ intToHexList remainder


addWithSign :: [Int] -> [Int] -> [Int]
addWithSign x y
    |     sgnx &&     sgny = addList signlessx signlessy 0 ++ [-1]
    | not sgnx && not sgny = addList x y 0 
    |     sgnx && not sgny = if compareList signlessx y
                             then subtractList signlessx y ++ [-1]
                             else subtractList y signlessx 
    | not sgnx &&     sgny = if compareList signlessy x
                             then subtractList signlessy x ++ [-1]
                             else subtractList x signlessy
    where sgnx = last x < 0
          sgny = last y < 0
          signlessx = init x
          signlessy = init y

compareList :: [Int] -> [Int] -> Bool
compareList x y
    | lenx == leny = last x > last y
    | otherwise = lenx > leny
    where lenx = length x
          leny = length y

subtractWithSign :: [Int] -> [Int] -> [Int]
subtractWithSign x y
    | compareList x y = subtractList x y
    | otherwise = subtractList y x ++ [-1]

subtractList :: [Int] -> [Int] -> [Int]
subtractList a b =
    let one = intToHexList 1
        padding = max (length a - length b) 0
        complement = complementList b ++ take padding (cycle [15])
        fstComplement = addList complement one 0
        dirtyResult = init (addList a fstComplement 0)
        cleanResult =  reverse$(dropWhile (==0))$reverse dirtyResult
    in if length cleanResult > 0 then cleanResult else [0]

complementList :: [Int] -> [Int]
complementList [] = [] 
complementList (h:t) = [15 - h] ++ complementList t


addList :: [Int] -> [Int] -> Int -> [Int]
addList [] [] carry = if carry > 0 then [carry] else []
addList [] (bh:bt) carry = [bh + carry] ++ bt 
addList (ah:at) [] carry = [ah + carry] ++ at 
--    let sum  = ah + carry
--        digit = mod sum 16
--        c     = div sum 16    
--    in [digit] ++uuu at 
addList (ah:at) (bh:bt) carry = 
    let sum = ah + bh + carry
        digit = mod sum 16
        c     = div sum 16
    in [digit] ++ addList at bt c


multList :: [Int] -> [Int] -> [Int]
multList x y = if length x > length y then mL x y 0 else mL y x 0

mL :: [Int] -> [Int] -> Int -> [Int]
mL a [] s = []
mL a (bh:bt) s = 
    let padding = take s (cycle [0])
        line = padding ++ (multLine a bh 0)
        nextLine = mL a bt (s+1)
    in addList line nextLine 0


multLine :: [Int] -> Int -> Int -> [Int]
multLine [] m c = if c > 0 then [c] else []
multLine (ah:at) m c =
    let prod  = ah * m + c
        digit = mod prod 16
        carry = div prod 16
    in [digit] ++  multLine at m carry
