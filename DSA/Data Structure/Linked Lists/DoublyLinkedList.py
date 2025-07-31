class Node:
    def __init__(self, value):
        self.data = value
        self.next = None
        self.back = None

class DoublyLinkedList:
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
            new_node.back = self.tail
            self.tail = new_node
        
        self.length += 1
        
    def prepend(self, value):
        new_node = Node(value)

        if not self.head:
            self.head = self.tail = new_node
        else:
            self.head.back = new_node
            new_node.next = self.head
            self.head = new_node

        self.length += 1
    
    def TraverseToIndex(self, index):
        current = self.head
        counter = 0
        while counter != index:
            current = current.next
            counter += 1

        return current
    
    def insert(self, index, value):
        if index < 0:
            return "Invalid index"
        elif index == 0:
            self.prepend(value)
            return self
        elif index >= self.length:
            self.append(value) 
            return self
        
        new_node = Node(value)

        leader = self.TraverseToIndex(index - 1)
        new_node.next = leader.next
        new_node.back = leader
        leader.next.back = new_node
        leader.next = new_node

        self.length += 1

    def remove(self, index):
        if index < 0 or index >= self.length:
            return "Invalid index"
        elif index == 0:
            self.head = self.head.next
            if self.head:
                self.head.back = None
            else:
                self.tail = None
            
            self.length -= 1
            return self
        
        pointer = self.TraverseToIndex(index - 1)
        UnWantedNode = pointer.next
        pointer.next = UnWantedNode.next
        if UnWantedNode.next:
            UnWantedNode.next.back = pointer
        else:
            self.tail = pointer
        self.length -= 1

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
            return "The list is empty"
        
        while current:
            print(current.data, end =" <-> " if current.next else "")
            current = current.next
        print()

lst = DoublyLinkedList()
lst.append(1)
lst.prepend(5)
lst.insert(3, 7)
lst.insert(1, 9)
lst.remove(3)
lst.reverse()
lst.print_list() 

