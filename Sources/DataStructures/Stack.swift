//
//  Stack.swift
//
//  Created by TJ Sartain on 9/28/20.
//  Copyright © 2020 iTrinity, Inc. All rights reserved.
//

import UIKit

public struct Stack<T>: CustomStringConvertible
{
    var array = [T]()
    
    public init()
    {
        array = [T]()
    }
    
    public var isEmpty: Bool
    {
        return array.isEmpty
    }
    
    public var count: Int
    {
        return array.count
    }
    
    public var description: String
    {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    public mutating func push(_ element: T)
    {
        array.append(element)
    }
    
    public mutating func pop() -> T?
    {
        return array.popLast()
    }
    
    public func peek() -> T?
    {
        return array.last
    }
}
