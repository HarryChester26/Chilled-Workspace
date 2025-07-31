class Node:
    def __init__(self, value):
        self.left = None
        self.right = None
        self.data = value

class BinarySearchTree():
    def __init__(self):
        self.root = None

    def insert(self, value):
        new_node = Node(value)
        if not self.root:
            self.root = new_node
        else:
            current = self.root
            while True:
                if new_node.data < current.data:
                    if not current.left:
                        current.left = new_node
                        return self
                    current = current.left
                else:
                    if not current.right:
                        current.right = new_node
                        return self
                    current = current.right

    def breadthFirstSearch(self):
        currentNode = self.root
        node_list = []
        queue = [currentNode]

        while len(queue) != 0:
            currentNode = queue.pop(0)
            node_list.append(currentNode.data)
            if currentNode.left:
                queue.append(currentNode.left)
            if currentNode.right:
                queue.append(currentNode.right)
        
        return node_list

    def breadthFirstSearchR(self, queue, node_list):
        if not queue:
            return node_list 

        currentNode = queue.pop(0) 
        node_list.append(currentNode.data)
        if currentNode.left:
            queue.append(currentNode.left)
        if currentNode.right:
            queue.append(currentNode.right)
        
        return self.breadthFirstSearchR(queue, node_list)
        

tree = BinarySearchTree()
tree.insert(9)
tree.insert(4)
tree.insert(6)
tree.insert(20)
tree.insert(170)
tree.insert(15)
tree.insert(1)
print(tree.breadthFirstSearch())
print(tree.breadthFirstSearchR([tree.root], []))