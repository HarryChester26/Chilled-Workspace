numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]
def selection_sort(array):
    for i in range(len(array)):
        smallest = array[i]
        for j in range(i, len(array)):
            if smallest > array[j]:
                smallest = array[j]
                index = j
        array[index], array[i] = array[i], array[index]
    
selection_sort(numbers)
print(numbers)


