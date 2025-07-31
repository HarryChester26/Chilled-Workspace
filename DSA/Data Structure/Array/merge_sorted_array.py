def mergeSortedArray(arr1, arr2):
    if len(arr1) == 0 or len(arr2) == 0:
        return arr1 + arr2
    result = []
    index1 = index2 = 0
    while index1 < len(arr1) and index2 < len(arr2):
        if arr1[index1] < arr2[index2]:
            result.append(arr1[index1])
            index1 += 1
        else:
            result.append(arr2[index2])
            index2 += 1
        
    return result + arr1[index1:] + arr2[index2:]

print(mergeSortedArray([0, 3, 4, 31], [4, 6, 30]))