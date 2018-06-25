//
//  File.swift
//  voice-calculator
//
//  Created by lz on 6/25/18.
//  Copyright © 2018 Zhuang Liu. All rights reserved.
//

import Foundation

//struct a stack data structure
struct Stack {
    fileprivate var array: [String] = []
    mutating func push(_ element: String) {
        array.append(element)
    }
    mutating func pop() -> String? {
        return array.popLast()
    }
    mutating func count() ->Int {
        return array.count
    }
}
