The Problem
===========

Suppose I give you a finite set of positive integers which may have repeated elements and I ask you to break up the set into two subsets whose sums (i.e. sums of the elements) are as close as possible.  Obviously, you could try all of the 2^n subsets individually (as I implemented in SlowBinaryPile.hs).  However, this method is clearly inefficient for large sets.  Thus, an algorithm is needed to do this more efficiently.  I have sought long and hard for a good algorithm, but so far my searches have come up dry.

Example
=======

Take the set {6,6,6,9,9}. This set can be broken up into a set {6,6,6} and {9,9}, where both sets have equal sums. However, some sets obviously cannot be broken up perfectly evenly.  For instance, the set {1,2,4} can be broken up into {1,2} and {4}, but the difference between these sums is 1.
