numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

def mergeSort(array):
    if len(array) == 1:
        return array
    # Split Array into right and left
    middle = len(array) // 2
    left = array[:middle]
    right = array[middle:]
    return merge(mergeSort(left), mergeSort(right))

def merge(left, right):
    result = []
    leftIndex = 0
    rightIndex = 0
    while leftIndex < len(left) and rightIndex < len(right):
        if left[leftIndex] > right[rightIndex]:
            result.append(right[rightIndex])
            rightIndex += 1
        else:
            result.append(left[leftIndex])
            leftIndex += 1
    
    return result + left[leftIndex:] + right[rightIndex:]

print(mergeSort(numbers))