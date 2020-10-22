//
//  File.swift
//  
//
//  Created by TJ Sartain on 10/22/20.
//

import Foundation

class BinarySearchTree<T: Comparable>: CustomStringConvertible
{
    private(set) var value: T
    private(set) var parent: BinarySearchTree?
    private(set) var left: BinarySearchTree?
    private(set) var right: BinarySearchTree?
    
    var isRoot: Bool {  parent == nil }
    var isLeaf: Bool { left == nil && right == nil }
    var isLeftChild: Bool { parent?.left === self }
    var isRightChild: Bool { parent?.right === self }
    var hasLeftChild: Bool { left != nil }
    var hasRightChild: Bool { right != nil }
    var hasAnyChild: Bool { hasLeftChild || hasRightChild }
    var hasBothChildren: Bool { hasLeftChild && hasRightChild }
    
    var count: Int
    {
        (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    var height: Int
    {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height ?? 0, right?.height ?? 0)
        }
    }
    
    var depth: Int
    {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    var description: String
    {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    
    init(_ value: T)
    {
        self.value = value
    }
    
    convenience init(array: [T])
    {
        precondition(array.count > 0)
        self.init(array.first!)
        for v in array.dropFirst() {
            insert(v)
        }
    }
    
    func insert(_ value: T)
    {
        if value < self.value {
            if let left = left {
                left.insert(value)
            } else {
                left = BinarySearchTree(value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value)
            } else {
                right = BinarySearchTree(value)
                right?.parent = self
            }
        }
    }
    
    func search(_ value: T) -> BinarySearchTree?
    {
        if value < self.value {
            return left?.search(value)
        } else if value > self.value {
            return right?.search(value)
        } else {
            return self  // found it!
        }
    }
    
    func traverseInOrder(process: (T) -> Void)
    {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    func traversePreOrder(process: (T) -> Void)
    {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    func traversePostOrder(process: (T) -> Void)
    {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
    
    func map(formula: (T) -> T) -> [T]
    {
        var a = [T]()
        if let left = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
    
    private func reconnectParentTo(node: BinarySearchTree?)
    {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    func minimum() -> BinarySearchTree
    {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    func maximum() -> BinarySearchTree
    {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    @discardableResult func remove() -> BinarySearchTree?
    {
        let replacement: BinarySearchTree?
        
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node:replacement)
        
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    func predecessor() -> BinarySearchTree<T>?
    {
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value < value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    func successor() -> BinarySearchTree<T>?
    {
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value > value { return parent }
                node = parent
            }
            return nil
        }
    }
}
