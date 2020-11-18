//
//  String.swift
//  AddOne
//
//  Created by Rodrigo Pecchio on 11/17/20.
//

import Foundation

extension String {
    // Generates random number for game mechanic
    static func randomNumber(length: Int) -> String {
        var result = ""
        
        for _ in 0..<length {
            let digit = Int.random(in: 0...9)
            result += "\(digit)"
        }
        
        return result
    }
    
    func integer(at n: Int) -> Int {
        let index = self.index(self.startIndex, offsetBy: n)
        return self[index].wholeNumberValue ?? 0
    }
}
