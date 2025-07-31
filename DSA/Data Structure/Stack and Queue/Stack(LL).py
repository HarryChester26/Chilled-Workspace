class Node:
    def __init__(self, value):
        self.data = value
        self.next = None

class Stack():
    def __init__(self):
        self.top = None
        self.bottom = None
        self.length = 0
    
    def peek(self):
        return self.top.data
    
    def push(self, value):
        new_node = Node(value)
        if not self.top:
            self.top = self.bottom = new_node
        else:
            new_node.next = self.top
            self.top = new_node
        
        self.length += 1

    def pop(self):
        if not self.top:
            return "The stack is empty"

        deleted_node = self.top

        if self.top == self.bottom:
            self.bottom = None

        self.top = self.top.next
        self.length -= 1

        return deleted_node
    
    def print_list(self):
        current = self.top
        
        while current:
            print(current.data, end= " -> " if current.next else "")
            current = current.next
        print()

myStack = Stack()
myStack.push("Udemy")
myStack.push("YouTube")
myStack.push("Facebook")
myStack.pop()
print(myStack.peek())
myStack.print_list()    