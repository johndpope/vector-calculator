//
//  String.swift
//  voice-calculator
//
//  Created by lz on 6/25/18.
//  Copyright © 2018 Zhuang Liu. All rights reserved.
//

import Foundation

extension String {
    func encodedOffset(of character: Character) -> Int? {
        return index(of: character)?.encodedOffset
    }
    func encodedOffset(of string: String) -> Int? {
        return range(of: string)?.lowerBound.encodedOffset
    }
    func indexOf(_ target: Character) -> Int? {
        return self.index(of: target)?.encodedOffset
    }
}
extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
