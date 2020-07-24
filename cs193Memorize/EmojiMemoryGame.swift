//
//  EmojiMemoryGame.swift
//  cs193Memorize
//
//  Created by Eason on 13/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import Foundation
import SwiftUI

//ViewModel
class EmojiMemoryGame:ObservableObject{
    //View - inside a house, ViewModel - door, Model - outside world
    //private - closed door, private(set) - closed glass door, can read but not write
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    //Ver 1
    //private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards:2, cardContentFactory: {
        //Ver 1.2
        //pairIndex in "🤣"
        //Ver 1.1
        //(pairIndex:Int)->String in return "🤣"
    //})
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairsOfCards:emojis.count){
            pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //Already defined when :ObservableObject
    //var objectWillChange: ObservableObjectPublisher
        
    //MARK: - Access to the Model
    var cards:Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card:MemoryGame<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
}
