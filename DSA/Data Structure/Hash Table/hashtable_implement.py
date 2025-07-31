class my_Dict:
    def __init__(self, size):
        self.data = [[] for _ in range(size)]

    def __str__(self):
        return str(self.__dict__)

    def _hash(self, key):
        # Return an int from 0 - 999 -> can occur collision due to limit space
        return sum(ord(char) for char in key) % 1000 

    def set(self, key, value):
        address = self._hash(key)
        self.data[address].append([key, value])
        
    def get(self, key):
        address = self._hash(key)
        currentBucket = self.data[address]
        if currentBucket:
            for i in range(len(currentBucket)):
                if currentBucket[i][0] == key:
                    return currentBucket[i][1]
        else:
            return None
        
    def keys(self):
        keysArray = []
        for bucket in self.data:
            for pair in bucket:
                keysArray.append(pair[0])
        return keysArray
        


myHashTable = my_Dict(1000)
myHashTable.set('grapes', 10000)
myHashTable.set('apples', 54)
print(myHashTable.get('grapes'))
print(myHashTable.keys())
    
    
