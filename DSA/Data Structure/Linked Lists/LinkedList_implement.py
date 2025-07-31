class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = self.tail = None
        self.length = 0

    def append(self, value):
        new_node = Node(value)
        if not self.head:
            self.head = new_node
            self.tail = self.head
        else:
            self.tail.next = new_node
            self.tail = new_node

        self.length += 1
        return self
    
    def prepend(self, value):
        new_node = Node(value)
        new_node.next = self.head
        self.head = new_node
        self.length += 1
        return self
    def TraverseToIndex(self, index):
        current = self.head
        counter = 0
        while counter != index:
            current = current.next
            counter += 1

        return current

    def insert(self, index, value):
        if index == 0:
            self.prepend(value)
            return self
        elif index > self.length:
            self.append(value)
            return self
        
        new_node = Node(value)
        leader = self.TraverseToIndex(index - 1)
        new_node.next = leader.next
        leader.next = new_node
        self.length += 1

        return self
    
    def remove(self, index):
        if index < 0 or index >= self.length:
            return "Invalid index"
        if index == 0:
            self.head = self.head.next
            return self

        leader = self.TraverseToIndex(index - 1)
        UnWantedNode = leader.next
        leader.next = UnWantedNode.next

        self.length -= 1

        return self    

    def reverse(self):
        if not self.head.next:
            return self
        
        first = self.head
        self.tail = self.head
        second = first.next

        while second:
            temp = second.next
            second.next = first
            first = second
            second = temp
        
        self.head.next = None
        self.head = first
    
    def print_list(self):
        current = self.head

        if not current:
            return "List is empty"
        
        while current:
            print(current.data, end= " -> " if current.next else "")
            current = current.next

        print() #for newline

lst = LinkedList()
lst.append(5)
lst.append(3)
lst.append(6)
lst.insert(200, 8)
lst.remove(0)
lst.reverse
lst.print_list()



        
    
