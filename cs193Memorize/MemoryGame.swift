//
//  MemoryGame.swift
//  cs193Memorize
//
//  Created by Eason on 13/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import Foundation

//Model
//data from http network or sql database
struct MemoryGame<CardContent> {
    //CardContent - don't care type
    var cards:Array<Card>
    
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        let chosenIndex:Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card:Card)->Int{
        for index in 0..<self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return -1 //TODO:bogus return
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory:(Int)->CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card:Identifiable {
        var isFaceUp: Bool = true
        var isMatch: Bool = false
        var content: CardContent //CardContent - don't care type
        var id:Int
    }
}
