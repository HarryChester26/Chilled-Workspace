from collections import defaultdict
def FRC(array):
    check_repeat = defaultdict(int)
    for num in array:
        check_repeat[num] += 1
        if check_repeat[num] >= 2:
            return num
    return None

print(FRC([2, 1, 3, 4]))