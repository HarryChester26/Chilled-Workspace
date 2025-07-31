numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]
def insertion_sort(array):
    size = len(array)
    for i in range(1, size):
        for j in range(i, 0, -1):
            if array[j] < array[j - 1]:
                array[j], array[j - 1] = array[j - 1], array[j]
            else:
                break  # Add this to avoid unnecessary swaps

            
        
insertion_sort(numbers)
print(numbers)
