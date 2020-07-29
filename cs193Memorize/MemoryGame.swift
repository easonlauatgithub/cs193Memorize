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
    var counter:Int = 0
    var willShowAlert:Bool = false
    
    mutating func choose(card: Card){
        //print("card chosen: \(card)")
        //let chosenIndex:Int = self.index(of: card)
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{ // one card face up already, indexOfTheOneAndOnlyFaceUpCard {get}
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    //Popup alert when all cards matched
                    counter+=1
                    if(counter*2 == cards.count){
                        print("willShowAlert")
                        self.willShowAlert = true
                    }
                    
                }
                //indexOfTheOneAndOnlyFaceUpCard = nil
                self.cards[chosenIndex].isFaceUp = true
            }else{ // no OR >1 card face up , indexOfTheOneAndOnlyFaceUpCard {set}
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
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
        cards.shuffle()
    }
    
    struct Card:Identifiable {
        var isFaceUp: Bool = false {
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent //CardContent - don't care type
        var id:Int
        
        //MARK: - Bonus Time
        var bonusTimeLimit:TimeInterval = 6
        //how long this card has ever been face up
        private var faceUpTime:TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince( lastFaceUpDate )
            }else{
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up ( and is still face up)
        var lastFaceUpDate:Date?
        //the accumulated time this card has been face up in the past
        // ie not including the current time it's been face up if it is currently so
        var pastFaceUpTime:TimeInterval = 0
        //how much time left before the bonus opportunity runs out
        var bonusTimeRemaining:TimeInterval{
            max(0,bonusTimeLimit-faceUpTime)
        }
        //percentage of the bonus time remaining
        var bonusRemaining:Double{
            (bonusTimeLimit>0 && bonusTimeRemaining>0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        //whether the card was matched during the bonus time period
        var hasEarnedBonus:Bool{
            isMatched && bonusTimeRemaining>0
        }
        //whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime:Bool{
            isFaceUp && !isMatched && bonusTimeRemaining>0
        }
        //called when the card transitios to face up state
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        //called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
