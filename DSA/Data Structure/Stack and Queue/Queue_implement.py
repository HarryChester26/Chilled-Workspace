class Node():
    def __init__(self, value):
        self.data = value
        self.next = None
    
class Queue():
    def __init__(self):
        self.first = self.last = None
        self.length = 0

    def peek(self):
        return self.first
    
    def enqueue(self, value):
        new_node = Node(value)
        if not self.first:
            self.first = self.last = new_node
        else:
            self.last.next = new_node
            self.last = new_node
        
        self.length += 1

    def dequeue(self):
        if not self.first:
            return None
        
        if self.length == 1:
            self.first = self.last = None
        else:
            self.first = self.first.next
        
        self.length -= 1

myQueue = Queue()
myQueue.enqueue("Joy")
myQueue.enqueue("Matt")
myQueue.enqueue("Pavel")
myQueue.enqueue("Samir")
myQueue.peek()
myQueue.dequeue()
myQueue.dequeue()