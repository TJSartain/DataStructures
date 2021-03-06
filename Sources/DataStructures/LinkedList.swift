//
//  LinkedList.swift
//
//  Created by TJ Sartain on 9/28/20.
//  Copyright © 2020 iTrinity, Inc. All rights reserved.
//

import UIKit

class LinkedList<T>: CustomStringConvertible
{
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    var size: Int = 0
    
    var isEmpty: Bool { head == nil }
    var first: Node<T>? { head }    
    var last: Node<T>? { tail }
    
    var description: String
    {
        var list = [String]()
        var node = head
        while node != nil {
            list.append("\(node!.value)")
            node = node!.next
        }
        return list.map { "\($0)" }.joined(separator: "\n")
    }
    
    func append(_ value: T)
    {
        let newNode = Node(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }
        else {
            head = newNode
        }
        tail = newNode
        size += 1
    }
    
    func nodeAt(index: Int) -> Node<T>?
    {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    func removeAll()
    {
        head = nil
        tail = nil
        size = 0
    }
    
    func remove(_ node: Node<T>) -> T
    {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        size -= 1
        if size < 0 { size = 0 }
        
        return node.value
    }
}

extension LinkedList where T: Equatable
{
    internal func contains(_ value: T) -> Bool
    {
        var node = head
        while node != nil {
            if node!.search(value: value) != nil { return true }
            node = node!.next
        }
        return false
    }
}


