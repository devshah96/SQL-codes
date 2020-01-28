# SQL-codes
SQL codes for the CS 527 database course.

KNN Classification model
Build a stored procedure called usp_knn for the O-Ring Failure dataset.
usp_knn accepts @temperature as input and returns the closest nearest neighbor (1NN) target using Euclidean distance.
Recommendation System
Build a lookup table called RS (ProductA varchar, ProductB varchar, Frq int).
Fill RS table using the list of products by order. For example, if an order has three product (B,C,E) then (B,C,1), (B,E,1) and (C,E,1) are the associated itemsets and the lookup table should be updated for each itemset.
Write a stored procedure that accepts a product name as the input and then recommends three products as the output.
