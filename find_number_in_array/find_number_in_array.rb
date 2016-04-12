#Suppose we had an array of n integers in sorted order. How quickly could we
#check if a given integer is in the array?

# num = 7
# [1, 3, 5, 7, 9, 10, 12, 13, 14, 15, ,17, 18, 19, 20]

1) we could use an binary tree to solve this problem.
  - divide array in half
    - first = [1, 3, 5, 7, 9, 10, 12] second = [13, 14, 15, 17, 18, 19, 20]
  - check if number is greater or less than num
    - if first.last > num
    - elsif second.first < num
  - repeat above steps until number is found or not
2) include?
