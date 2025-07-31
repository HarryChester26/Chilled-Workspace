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
    
    def lookup(self, value):
        if not self.root:
            return "The tree is empty"
        current = self.root
        while current:
            if value < current.data:
                current = current.left
            elif value > current.data:
                current = current.right
            else:
                return f"{value} found!"
        return f"{value} not found!"
    
    def remove(self, value):
        if not self.root:
            return False
        
        currentNode = self.root
        parentNode = None
        
        while currentNode:
            if value < currentNode.data:
                parentNode = currentNode
                currentNode = currentNode.left
            elif value > currentNode.data:
                parentNode = currentNode
                currentNode = currentNode.right
            else:
                # No right child
                if currentNode.right is None:
                    if parentNode is None:
                        self.root = currentNode.left
                    else:
                        if parentNode.data > currentNode.data:
                            parentNode.left = currentNode.left
                        else:
                            parentNode.right = currentNode.left
                elif currentNode.right:
                    # Has a right child but no left child
                    if currentNode.right.left is None:
                        if parentNode is None:
                            self.root = currentNode.right
                            return self
                        
                        if parentNode.data > currentNode.data:
                            parentNode.left = currentNode.right
                        else:
                            parentNode.right = currentNode.right
                    else:
                    # Has left child
                        leftmost = currentNode.right.left
                        leftmostParent = currentNode.right
                        # Find the right child's leftmost child
                        while leftmost.left:
                            leftmostParent = leftmost
                            leftmost = leftmost.left
                        # Parent's left subtree is now leftmost's right subtree
                        leftmostParent.left = leftmost.right
                        leftmost.left = currentNode.left
                        leftmost.right = currentNode.right

                        if parentNode is None:
                            self.root = leftmost
                        
                        if parentNode.data > currentNode.data:
                            parentNode.left = leftmost
                        else:
                            parentNode.right = leftmost
                         


tree = BinarySearchTree()
tree.insert(9)
tree.insert(4)
tree.insert(6)
tree.insert(20)
tree.insert(170)
tree.insert(15)
tree.insert(1)
print(tree.lookup(99))
