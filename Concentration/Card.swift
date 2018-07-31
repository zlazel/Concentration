//
//  Card.swift
//  Concentration
//
//  Created by AhmedZlazel on 5/24/18.
//  Copyright © 2018 AhmedZlazel. All rights reserved.
//

import Foundation
struct Card: Hashable
{
    var hashValue: Int{ return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUP = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
