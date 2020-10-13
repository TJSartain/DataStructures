//
//  Stack.swift
//  Viewer3D
//
//  Created by TJ Sartain on 9/28/20.
//  Copyright © 2020 iTrinity, Inc. All rights reserved.
//

import UIKit

struct Stack<T>: CustomStringConvertible
{
    fileprivate var array = [T]()
    
    var isEmpty: Bool
    {
        return array.isEmpty
    }
    
    var count: Int
    {
        return array.count
    }
    
    var description: String
    {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        let stackElements = array.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    mutating func push(_ element: T)
    {
        array.append(element)
    }
    
    mutating func pop() -> T?
    {
        return array.popLast()
    }
    
    func peek() -> T?
    {
        return array.last
    }
}
