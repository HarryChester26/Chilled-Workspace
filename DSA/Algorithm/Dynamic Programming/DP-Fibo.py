# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, ...
def fibonacci(n): # O(2^n)
    if n < 2:
        return n
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)

def fibonacciMaster(): # O(n) - Top down
    cache = {}
    def fib(n):
        if n in cache:
            return cache[n]
        else:
            if n < 2:
                return n
            else:
                cache[n] =  fib(n - 1) + fib(n - 2)

                return cache[n]
    return fib

def fibonacciMaster2(n): # O(n) - Bottom up
    result = [0, 1]
    for i in range(2, n + 1):
        result.append(result[i -1] + result[i - 2])
        
    return result.pop()
fasterFib = fibonacciMaster()
print(fasterFib(100)) 