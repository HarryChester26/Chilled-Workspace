class Array:
    def __init__(self):
        self.length = 0
        self.data = {}
    
    def __str__(self):
        return str(self.__dict__)

    def push(self, item):
        self.data[self.length] = item
        self.length += 1
        return self.length
    
    def pop(self):
        if self.length == 0:
            return "The array is empty"
        
        lastItem = self.data[self.length - 1]
        del self.data[self.length - 1]
        self.length -= 1

        return lastItem
    
    def delete(self, index):
        item = self.data[index]
        for i in range(index, self.length - 1):
            self.data[i] = self.data[i + 1]

        del self.data[self.length - 1]
        self.length -= 1

        return item

    
newArray = Array()
newArray.push('Hello, Worlds!')
newArray.push("Henry")
newArray.push(30)
newArray.push(36)
newArray.pop()
newArray.delete(2)
print(newArray)
