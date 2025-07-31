def bubble_sort(array):
    for _ in range(len(array)):
        for i in range(len(array) - 1):
            if array[i] > array[i + 1]:
                array[i], array[i + 1] = array[i + 1], array[i]
        
a = [5, 3 ,2 ,7 ,1, 4]
bubble_sort(a)
print(a)