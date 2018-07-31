//
//  ViewController.swift
//  Concentration
//  
//  Created by AhmedZlazel on 5/24/18.
//  Copyright © 2018 AhmedZlazel. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    @IBOutlet private weak var flipCountLable: UILabel!{
        didSet{
            updateFilpCountLable()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden  }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = visibleCardButtons.index(of: sender){
            game.chosseCard(at: cardNumber)
            updateViewFromModel()
            if game.cards[cardNumber].isFaceUP{
                filpCount += 1
            }
        }else{
            print("card is not in card Buttons")
        }
    }
    
    private lazy var game = Concentration(numbersOfPairsOfCards: numbersOfPairsOfCard)
    
    var numbersOfPairsOfCard :Int{
        return (visibleCardButtons.count + 1) / 2
    }
    private var filpCount = 0
    {
        didSet{
            updateFilpCountLable()
        }
        
    }
    private func updateFilpCountLable(){
        let attributes :[NSAttributedStringKey :Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(filpCount)" :  "Flips:\(filpCount)" ,
            attributes: attributes
        )
        flipCountLable.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFilpCountLable()
    }
    
    private func updateViewFromModel(){
        if visibleCardButtons != nil{
            for index in visibleCardButtons.indices{
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUP{
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :#colorLiteral(red: 0, green: 0.1908044441, blue: 1, alpha: 1)
                }
            }
        }}
    var theme: String?{
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🎯🚘⏰🎃👻🙉🦋🌻🚴‍♀️"
    private var emoji = [Card:String]()
    
    private  func emoji(for card :Card) -> String
    {
        if emoji[card] == nil , emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return  -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}








