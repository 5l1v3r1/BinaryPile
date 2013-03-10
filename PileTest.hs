-- This basic script can be used to find counterexamples
-- in a binary split algorithm

import qualified BinaryPile
import qualified SlowBinaryPile

main :: IO ()
main = do
    let sets = allSets 10 2
    testSets sets

testSets :: [[Int]] -> IO ()
testSets (x:xs) = do
    let (aBasic, bBasic) = SlowBinaryPile.binarySplit x
        (aFast, bFast) = BinaryPile.binarySplit ((map fromIntegral x) :: [Double])
        err1 = listError x bBasic
        err2 = listError x (map round bFast)
    if err1 /= err2
    then putStrLn $ "counterexample found " ++ (show err1) ++ " " ++ (show err2) ++ " set: " ++ (show x)
    else return ()
    testSets xs

listSum :: (Integral a) => [a] -> a
listSum = foldl (\a b -> a + b) 0

listError :: (Integral a, Ord a) => [a] -> [a] -> Int
listError full choice = let totalSum = foldl (\a b -> a + b) 0
                            choiceSum = fromIntegral $ totalSum choice
                            fullSum = fromIntegral $ totalSum full
                        in abs $ (choiceSum - (fullSum - choiceSum))


allSets :: Int -> Int -> [[Int]]
allSets maxLength maxValues = setGenerator maxLength 1 maxValues []
    
setGenerator :: Int -> Int -> Int -> [Int] -> [[Int]]
setGenerator lengthLeft curVal maxVal list
    | lengthLeft == 0 = []
    | curVal > maxVal = []
    | otherwise = let nextSets = setGenerator (lengthLeft) (curVal + 1) maxVal list
                      thisNext = curVal:list
                      nextRecurse = setGenerator (lengthLeft - 1) 1 maxVal thisNext
                  in thisNext:(nextSets ++ nextRecurse)
