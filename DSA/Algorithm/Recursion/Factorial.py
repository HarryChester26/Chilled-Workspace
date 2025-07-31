def findFactorialRecursive(number):  # O(n)
    if number == 2:
        return 2

    return number * findFactorialRecursive(number - 1)


def findFactorialIterative(number):  # O(n)
    result = 1
    if number <= 2:
        return number
    for i in range(1, number + 1):
        result *= i

    return result


print(findFactorialIterative(5))
print(findFactorialRecursive(5))

