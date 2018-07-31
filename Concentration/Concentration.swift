//
//  Concentration.swift
//  Concentration
//
//  Created by AhmedZlazel on 5/24/18.
//  Copyright © 2018 AhmedZlazel. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFacedUpCard:Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUP}.oneAndOnly
            //            var foundIndex: Int?
//            for i in cards.indices{
//                if cards[i].isFaceUP{
//                    if foundIndex == nil{
//                        foundIndex = i
//                    }
//                    else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for i in cards.indices{
                cards[i].isFaceUP = ( i == newValue )
            }
        }
    }
    
    func chosseCard(at index :Int){
        assert(cards.indices.contains(index), "Concentration.chosseCard(at : \(index) : chosen index not in th cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFacedUpCard  ,matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
            }else{
                indexOfOneAndOnlyFacedUpCard = index
            }
        }else{
            
        }
    }
    init(numbersOfPairsOfCards : Int){
        assert( numbersOfPairsOfCards > 0 , "Concentration.init(\(numbersOfPairsOfCards)) : you must have one pair of cards at least")
        for _ in 1...numbersOfPairsOfCards
        {
            let card = Card()
            cards += [card , card]
        }
    }
}
extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first :nil
    }
}
