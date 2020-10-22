//
//  Node.swift
//  
//
//  Created by TJ Sartain on 10/22/20.
//

import Foundation

class Node<T>: CustomStringConvertible
{
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    var children: [Node<T>] = []
    weak var parent: Node<T>?
    
    var description: String
    {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
    
    init(value: T)
    {
        self.value = value
    }
    
    func add(child: Node<T>)
    {
        children.append(child)
        child.parent = self
    }
}

extension Node where T: Equatable
{
    func search(value: T) -> Node?
    {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}
