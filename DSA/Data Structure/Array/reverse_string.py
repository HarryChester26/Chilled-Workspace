# Create a function that reverses a string:
# 'Hi My Name is Henry' should be
# 'yrneH si emaN yM iH'
def reverse(str):
    arr = []
    for i in range(len(str)):
        arr.append(str[i])
    
    for i in range(len(arr)):
        print(arr[len(arr) - 1 - i], end = '')

reverse('Hi My Name is Henry')