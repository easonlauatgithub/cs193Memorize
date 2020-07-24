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
struct MemoryGame<CardContent> where CardContent:Equatable{
    //CardContent - don't care type
    private(set) var cards:Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            var faceUpCardIndices = [Int]()
            for index in cards.indices{
                if cards[index].isFaceUp{
                    faceUpCardIndices.append(index)
                }
            }
            return faceUpCardIndices.only
            if faceUpCardIndices.count == 1{
                return faceUpCardIndices.first
            }else{
                return nil
            }
        }
        set{
            for index in cards.indices{
                if index == newValue{
                //newValue = indexOfTheOneAndOnlyFaceUpCard when set
                    cards[index].isFaceUp = true
                }else{
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card: Card){
        //print("card chosen: \(card)")
        //let chosenIndex:Int = self.index(of: card)
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{ // one card face up already
                //indexOfTheOneAndOnlyFaceUpCard {get}
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                //indexOfTheOneAndOnlyFaceUpCard = nil
                self.cards[chosenIndex].isFaceUp = true
            }else{ // no card face up
                //for index in cards.indices{cards[index].isFaceUp = false}
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                //indexOfTheOneAndOnlyFaceUpCard {set}
            }
            //self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        }
    }
    /*
    func index(of card:Card)->Int{
        for index in 0..<self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return -1 //TODO:bogus return
    }
     */
    init(numberOfPairsOfCards: Int, cardContentFactory:(Int)->CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card:Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent //CardContent - don't care type
        var id:Int
    }
}
