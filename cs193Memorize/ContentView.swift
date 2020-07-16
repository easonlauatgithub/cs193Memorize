//
//  ContentView.swift
//  cs193Memorize
//
//  Created by Eason on 13/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //init at SceneDelegate.swift
    //let game = EmojiMemoryGame()
    //let contentView = ContentView(viewModel: game)
    var viewModel: EmojiMemoryGame
    
    //some - this property is any type, any struct, as long as it behaves like a View
    //as long as it is some View
    //it may return a combiner View/lego, with tons and tons of View inside that are combined
    //Ask combine to figure out what body is returning, make sure it behaves like a View
    var body: some View {
        let foreachStack =  ForEach(viewModel.cards, content: {
        //let foreachStack =  ForEach(0..<viewModel.cards.count, content: {
            card in
            CardView(card: card).onTapGesture{
                self.viewModel.choose(card: card)
            }
            //CardView(isFaceUp: true)
        })
        
        return HStack(content: {
            foreachStack
        })
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView:View{
    //var isFaceUp:Bool
    var card:MemoryGame<String>.Card
    var body:some View{
        ZStack{
            if card.isFaceUp {
            //if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
                //Text("👻")
            }else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}
struct CardViewVer1:View{
    var body:some View{
        ZStack(){
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
            Text("👻")
            Text("ABC")
        }
    }
}
struct CardViewVer0:View{
    var body:some View{
        ZStack(content: {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
            Text("👻")
            Text("ABC")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
