//: Playground - noun: a place where people can play

import UIKit

class LLNode <T> {
    var key: T!
    var next: LLNode?
    var prev: LLNode?
}

var str:String = "Swift Practice"

class LinkedList <T: Equatable> {
    
    var head: LLNode<T> = LLNode<T>()
    var count: Int = 0
    
    // append new item
    func addLink(key: T) {
        
        if head.key == nil  {
        
            head.key = key
            count++
            return
        }
        
        // find tail node
        var tailNode :LLNode? = head
        
        while tailNode != nil {
            
            if tailNode?.next == nil { // found tail node
                
                // create new node and add tail, new tail = new node
                let newNode: LLNode = LLNode<T>()
                
                newNode.key = key
                newNode.prev = tailNode
                tailNode?.next = newNode // new tail
                
                break

            } else {
                
                tailNode = tailNode?.next // seek to next node
            }
        }
        count++
    }
    
    func printAllKey() -> Void {
        
        var currNode:LLNode! = head
        
        while currNode != nil {
            
            print("Key: \(currNode.key)")
            currNode = currNode.next
        }
        
        print("\(count) items")
    }
    
    func insertNodeAtIndex( key: T, index: Int ) ->Void {
        
        if index < 0 || index > self.count - 1 {
            print( "invalid index" )
        }
        
        if head.key == nil {
            
            head.key = key
            count++
            return
        }
        
        var currentNode: LLNode<T>? = head
        var trailNode: LLNode<T>?
        var listIndex: Int = 0
        
        while currentNode != nil {
            
            if index == listIndex { // index need to be insert
                
                let childNode: LLNode = LLNode<T>() // create new node
                
                childNode.key = key
                childNode.next = currentNode
                childNode.prev = trailNode
                
                // insert node
                if let linkTrailer = trailNode {
                    linkTrailer.next = childNode // point next node of prevNode to new node
                    childNode.prev = linkTrailer
                }
                
                currentNode!.prev = childNode // point prev note of current node
                
                // update head
                if index == 0 {
                    head = childNode
                }
                
                count++
                break
            }
            // next
            trailNode = currentNode
            currentNode = currentNode?.next
            listIndex += 1
        }
    }

}

func testList() -> Void {
    
    let linkedList: LinkedList<String> = LinkedList<String>()
    
    linkedList.addLink("Father")
    linkedList.addLink("Mother")
    linkedList.addLink("Son")
    linkedList.addLink("Sister")
    linkedList.addLink("Sister3")
    linkedList.addLink("Sister2")
    linkedList.insertNodeAtIndex("Brother", index: 2)
    
    linkedList.printAllKey()
    
}

testList()

class AVLTree <T: Comparable> {
    
    var key: T?
    var left: AVLTree?
    var right: AVLTree?
    var nodeHeight: Int!
    
    
    init () {
        self.nodeHeight = -1
    }
    
    // func Add a Node
    func addNode(key: T) -> Void {
        
        if self.key == nil {
            
            self.key = key
            
            return
        }
        
        if key < self.key {
            
            if self.left != nil {
                
                left?.addNode(key)
                
            }
            
            else {
            
                var newLeafNode: AVLTree = AVLTree<T>()
                newLeafNode.key = key
                self.left = newLeafNode
                
            }
            
            self.setNodeHeight()
        }
        
        else if key > self.key {
            
            if self.right != nil {
                
                right?.addNode(key)
                
            }
            
            else {
                
                var newLeafNode: AVLTree = AVLTree<T>()
                newLeafNode.key = key
                self.right = newLeafNode
                
            }
            
            self.setNodeHeight()
            
        }
        
        else {
            print("Duplicated key")
        }
    }
    
    func findNode(key: T) -> Void {
        if self.key == nil {
            print("Can not found")
            return
        }
        
        if key == self.key {
            print("Found!")
            return
        }
        
        if key < self.key {
            
            if self.left != nil {
                self.left?.findNode(key)
            }
            else{
                print("Can not found")
                return;
            }
            
        }
        
        if key > self.key {
            
            if self.right != nil {
                self.right?.findNode(key)
            }
            else {
                print("Can not found")
                return;
            }
            
        }
    }
    
    // get node height
    func getNodeHeight (anode: AVLTree!) -> Int {
        if anode == nil {
            return -1
        }
        else {
            return anode.nodeHeight
        }
    }
    
    func setNodeHeight () -> Bool {
        
        if self.key == nil {
            return false
        }
        
        var height: Int = 0
        height = max ( getNodeHeight( self.left ), getNodeHeight( self.right ) ) + 1
        self.nodeHeight = height
        
        return true
    }
    
    func isTreeBalance () -> Bool {
        
        if self.key == nil {
            return false
        }
        
        if  ( abs( self.getNodeHeight(self.left) - self.getNodeHeight(self.right)) <= 1 )  {
            return true
        }
        
        return false
        
    }
    
    func balanceTree() ->Bool! {
        
        if self.key == nil {
            return false
        }
        
        if self.isTreeBalance() == true {
            return false
        }
        
        var tempNode:AVLTree = AVLTree<T>()
        tempNode.key = self.key
        tempNode.nodeHeight = 0
        
        if getNodeHeight(self.left) - getNodeHeight(self.right) > 1 {
            
            print("\n starting right rotation on \(self.key!)..")
            
            self.key = self.left?.key
            self.nodeHeight = self.getNodeHeight(self.left)
            self.right = tempNode
            
            self.left = self.left?.left
            self.left?.nodeHeight = 0
            
            print("root is: \(self.key!) | left is : \(self.left!.key!) | right is : \(self.right!.key!)..")
            return true
        }
        
        if getNodeHeight(self.right) - getNodeHeight(self.left) > 1 {
            
            print("\n starting left rotation on \(self.key!)..")
            
            self.key = self.right?.key
            self.nodeHeight = getNodeHeight(self.right)
            self.left = tempNode
            
            self.right = self.right?.right
            self.right?.nodeHeight = 0
         
            print("root is: \(self.key!) | left is : \(self.left!.key!) | right is : \(self.right!.key!)..")
            return true
        }
        
        return nil
    }
}

var aTree:AVLTree = AVLTree<Int>()
aTree.addNode(15)
aTree.addNode(13)
aTree.addNode(18)
aTree.addNode(20)
aTree.addNode(7)
aTree.addNode(6)
aTree.addNode(9)
aTree.addNode(19)
aTree.addNode(91)
aTree.addNode(112)
aTree.addNode(2)
aTree.addNode(22)
aTree.addNode(23)
aTree.addNode(24)
aTree.addNode(25)
aTree.addNode(27)

aTree.balanceTree()
aTree.getNodeHeight(aTree.left)
aTree.getNodeHeight(aTree.right)





