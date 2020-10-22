//
//  Queue.swift
//
//  Created by TJ Sartain on 9/28/20.
//  Copyright © 2020 iTrinity, Inc. All rights reserved.
//

import UIKit

struct Queue<T>: CustomStringConvertible
{
    fileprivate var list = LinkedList<T>()
    
    var isEmpty: Bool
    {
        return list.isEmpty
    }
    
    var description: String
    {
        return list.description
    }
    
    mutating func enqueue(_ element: T)
    {
        list.append(element)
    }
    
    mutating func dequeue() -> T?
    {
        guard !list.isEmpty, let element = list.first else { return nil }
        
        _ = list.remove(element)
        
        return element.value
    }
    
    func peek() -> T?
    {
        return list.first?.value
    }
}
