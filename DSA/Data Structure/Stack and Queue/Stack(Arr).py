class Stack():
    def __init__(self):
        self.array = []
        self.length = 0
    
    def peek(self):
        if self.length == 0:
            return None
        else:
            return self.array[self.length - 1]
        
    def push(self, value):
        self.array.append(value)
        self.length += 1 

    def pop(self):
        if self.length == 0:
            return "The stack is empty"
        
        self.length -= 1
        return self.array.pop()
    
myStack = Stack()
myStack.push("Udemy")
myStack.push("YouTube")
myStack.push("Facebook")
print(myStack.pop())
print(myStack.peek())



