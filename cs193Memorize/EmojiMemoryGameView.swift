//
//  ContentView.swift
//  cs193Memorize
//
//  Created by Eason on 13/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    //init at SceneDelegate.swift
    //let game = EmojiMemoryGame()
    //let contentView = ContentView(viewModel: game)
    @ObservedObject var viewModel: EmojiMemoryGame
    
    //some - this property is any type, any struct, as long as it behaves like a View
    //as long as it is some View
    //it may return a combiner View/lego, with tons and tons of View inside that are combined
    //Ask combine to figure out what body is returning, make sure it behaves like a View
    var body: some View {
        let foreachStack =  ForEach(viewModel.cards, content: {
        //let foreachStack =  ForEach(0..<viewModel.cards.count, content: {
            card in
            CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture{
                self.viewModel.choose(card: card)
            }
            //CardView(isFaceUp: true)
        })
        
        return HStack(content: {
            foreachStack
        })
        .padding()
        .foregroundColor(Color.orange)
        
    }
}

struct CardView:View{
    //var isFaceUp:Bool
    var card:MemoryGame<String>.Card
    var body:some View{
        GeometryReader(content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    func body(for size:CGSize)->some View{
        ZStack{
            if card.isFaceUp {
            //if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
                //Text("👻")
            }else{
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        //.font(Font.largeTitle)
        .font(Font.system(size: fontSize(for: size)))
    }
    // MARK: - Drawing Constants
    let cornerRadius:CGFloat = 10
    let edgeLineWidth:CGFloat = 3
    func fontSize(for size:CGSize)->CGFloat{
        min(size.width, size.height) * 0.75
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
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
