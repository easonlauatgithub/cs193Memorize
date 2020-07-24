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
        Grid(viewModel.cards){ card in
            CardView(card: card).onTapGesture{
                self.viewModel.choose(card: card)
            }
        .padding(5)
        }
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
    
    @ViewBuilder
    private func body(for size:CGSize)->some View{
        if card.isFaceUp || !card.isMatched{
            ZStack{
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(90-90), clockwise: true).padding(5).opacity(0.5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            //.modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp:card.isFaceUp)
        }
    }

    // MARK: - Drawing Constants
    //private let cornerRadius:CGFloat = 10
    //private let edgeLineWidth:CGFloat = 3
    private func fontSize(for size:CGSize)->CGFloat{
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
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        let contentView = EmojiMemoryGameView(viewModel: game)
        return contentView
    }
}
