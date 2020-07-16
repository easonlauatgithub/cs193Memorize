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
    
    func choose(card: Card){
        print("card chosen: \(card)")
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
