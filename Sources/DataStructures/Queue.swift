//
//  Queue.swift
//
//  Created by TJ Sartain on 9/28/20.
//  Copyright © 2020 iTrinity, Inc. All rights reserved.
//

import UIKit

public struct Queue<T>: CustomStringConvertible
{
    var list = LinkedList<T>()
    
    public init()
    {
        list = LinkedList<T>()
    }
    
    public var size: Int
    {
        list.size
    }
    
    public var isEmpty: Bool
    {
        list.isEmpty
    }
    
    public var description: String
    {
        return list.description
    }
    
    public mutating func add(_ element: T)
    {
        list.append(element)
    }
    
    public mutating func remove() -> T?
    {
        guard !list.isEmpty, let element = list.first else { return nil }
        
        _ = list.remove(element)
        
        return element.value
    }
    
    public func peek() -> T?
    {
        list.first?.value
    }
}

extension Queue where T: Equatable
{
    public func contains(_ value: T) -> Bool
    {
        list.contains(value)
    }
    
    public func repeated(_ item: T) -> Bool
    {
        list.size > 0 && list.last!.value == item
    }
}
