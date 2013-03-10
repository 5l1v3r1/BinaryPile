module SlowBinaryPile (
    binarySplit
) where

import Data.List

rollingChoose :: (Integral a, Ord a) => [a] -> [a] -> Int -> ([a] -> [a] -> [a]) -> [a]
rollingChoose list pastList count comparator
    | count == 0 = pastList
    | otherwise  = if length list < count then []
                   else let firstPast = (head list):pastList
                            firstList = tail list
                            firstOpt = rollingChoose firstList firstPast (count - 1) comparator
                            otherPast = pastList
                            otherList = tail list
                            otherOpt = rollingChoose otherList otherPast count comparator
                        in comparator firstOpt otherOpt

choiceError :: (Integral a, Ord a) => [a] -> [a] -> Int
choiceError full choice = let totalSum = foldl (\a b -> a + b) 0
                              choiceSum = fromIntegral $ totalSum choice
                              fullSum = fromIntegral $ totalSum full
                          in abs $ (choiceSum - (fullSum - choiceSum))

pickBestChoice :: (Integral a, Ord a) => [a] -> Int -> [a]
pickBestChoice list size
    | size == 1 = rollingChoose list [] size (comparison list)
    | otherwise = let thisChoice = rollingChoose list [] size (comparison list)
                      lowerChoice = rollingChoose list [] (size - 1) (comparison list)
                  in comparison list thisChoice lowerChoice

comparison :: (Integral a, Ord a) => [a] -> [a] -> [a] -> [a]
comparison total a b = if (choiceError total a) < (choiceError total b) then a else b

binarySplit :: (Integral a, Ord a) => [a] -> ([a], [a])
binarySplit [] = ([], [])
binarySplit (a:[]) = ([a], [])
binarySplit list = let maxSize = floor $ (fromIntegral (length list)) / 2 :: Int
                       leftPile = pickBestChoice list maxSize
                       rightPile = setRemove list leftPile []
                   in (leftPile, rightPile)

setRemove :: (Integral a) => [a] -> [a] -> [a] -> [a]
setRemove set subset result
    | length set == 0 = result
    | otherwise = let testRem = head set
                  in if testRem `elem` subset
                     then setRemove (tail set) (delete testRem subset) result
                     else setRemove (tail set) subset (testRem:result)
