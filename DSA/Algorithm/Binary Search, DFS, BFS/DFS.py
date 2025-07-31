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

    def DFS_inorder(self):
        return self.traverse_inorder(self.root, [])

    def DFS_postorder(self):
        return self.traverse_postorder(self.root, [])

    def DFS_preorder(self):
        return self.traverse_preorder(self.root, [])

    def traverse_inorder(self, node, list):

        if node.left:
            self.traverse_inorder(node.left, list) 

        list.append(node.data)

        if node.right:
            self.traverse_inorder(node.right, list)        

        return list
    
    def traverse_postorder(self, node, list):

        if node.left:
            self.traverse_postorder(node.left, list) 

        if node.right:
            self.traverse_postorder(node.right, list)        

        list.append(node.data)

        return list
    
    def traverse_preorder(self, node, list):
        
        list.append(node.data)

        if node.left:
            self.traverse_preorder(node.left, list) 

        if node.right:
            self.traverse_preorder(node.right, list)        

        return list
tree = BinarySearchTree()
tree.insert(9)
tree.insert(4)
tree.insert(6)
tree.insert(20)
tree.insert(170)
tree.insert(15)
tree.insert(1)
print(tree.DFS_inorder())
print(tree.DFS_postorder())
print(tree.DFS_preorder())