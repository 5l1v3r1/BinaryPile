-- This algorithm certainly seemed like it would work at the time,
-- but [1,1,2,2,2,2,2,2,2,2] is a computed counterexample
module BinaryPile (
	binarySplit
) where

import Data.List

sortClosest :: (Num a, Ord a) => a -> [a] -> [a]
sortClosest _ [] = []
sortClosest x (y:ys) = (sortClosest x closer) ++ [y] ++ (sortClosest x farther)
	where diff = abs $ y - x
	      closer = filter (\v -> (abs $ v - x) < diff) ys
	      farther = filter (\v -> (abs $ v - x) >= diff) ys

avgGroup :: (Fractional a, Ord a) => [a] -> Int -> [a]
avgGroup [] _ = []
avgGroup all x = take x $ sortClosest target all
	where target = (sum all) / ((fromIntegral x) * 2)

binarySplit :: (Fractional a, Ord a, Num a) => [a] -> ([a], [a])
binarySplit [] = ([], [])
binarySplit (a:[]) = ([a], [])
binarySplit xs = (pile1, pile2)
	where destination = (sum xs) / 2
	      listOffset a = abs $ destination - (sum a)
	      closerOffset a b = if listOffset a < listOffset b then a else b
	      groups = map (avgGroup xs) [1..(length xs) - 1]
	      pile1 = foldl closerOffset xs groups
	      pile2 = foldr delete xs pile1