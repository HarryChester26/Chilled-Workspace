# Identify the base case
# Identify the recursive case
# Get closer and closer and return when needed. Usually you have 2 returns

def fibonacciIterative(n):
    arr = [0, 1]
    
    for i in range(2, n + 1):
        arr.append(arr[i - 1] + arr[i - 2])

    return arr[n]

def fibonacciRecursive(n): # O(2^n)
    if n < 2:
        return n
    else:
        return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2)
    
print(fibonacciRecursive(6))
print(fibonacciIterative(6))