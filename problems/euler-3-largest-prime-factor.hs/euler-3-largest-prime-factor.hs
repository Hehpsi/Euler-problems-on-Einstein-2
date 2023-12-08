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
           in print (eulerSolution num)
    else putStrLn "Invalid Input"



-- Solution
eulerSolution :: Int -> Int
eulerSolution n =
    let primes = filter isPrime ([2,3,5] ++ [x | x <- [3,5..], (mod x 3 * mod x 5) > 0])
        num = fromIntegral n :: Double
    in round $ lpf num primes
isPrime k = if k > 1 then null [ x | x <- [2..k - 1], k `mod` x == 0] else False

fract :: Double -> Double
fract x = (x - fromIntegral (floor x) :: Double)


lpf :: Double -> [Integer] -> Double
lpf 1.0 (prime:primeList) = fromIntegral prime :: Double
lpf num (prime:primeList)
    | fract(result) > 0        = lpf num primeList
    | (isPrime . round) result = result 
    | otherwise                = lpf result (prime:primeList)
    where primeButDouble = fromIntegral prime :: Double
          result         = num / primeButDouble
