//
//  ContentView.swift
//  cs193Memorize
//
//  Created by Eason on 13/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//
import SwiftUI

///init at SceneDelegate.swift;
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    //some - this property is any type, any struct, as long as it behaves like a View
    //as long as it is some View
    //it may return a combiner View/lego, with tons and tons of View inside that are combined
    //Ask combine to figure out what body is returning, make sure it behaves like a View
    var body: some View {
        VStack {
            Grid(viewModel.cards){ card in
                CardView(card: card).onTapGesture{
                    withAnimation(.linear(duration:0.75), {
                        self.viewModel.choose(card: card)
                    })
                }
            .padding(5)
            }
            .padding()
            .foregroundColor(Color.green)
            
            Button(
                action:{
                    withAnimation(.easeInOut, {self.viewModel.resetGame()})
                }, label: {
                    Text("New Game")
                }
            )
        }
        //Alert
        .alert(isPresented: $viewModel.willShowAlert, content: {
            Alert(title: Text("New Game"),
                  message: Text("Try another round?"),
                  //dismissButton: .cancel(),
                primaryButton: .default(Text("New Game")) {
                    withAnimation(
                        .easeInOut,
                        {self.viewModel.resetGame()}
                    )
                },
                secondaryButton: .destructive(Text("Quit")){ print("quit game") }
            )
        })
        /*
        //ActionSheet
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [.default(Text("Dismiss Action Sheet"))])
        }
        //Context Menu
        .contextMenu {
            Button(action: {
                // change country setting
            }) {Text("Choose Country");Image(systemName: "globe")}
            Button(action: {
                // enable geolocation
            }) {Text("Detect Location");Image(systemName: "location.circle")}
        }*/

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
    
    @State private var animatedBonusRemaining:Double = 0
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    @ViewBuilder
    private func body(for size:CGSize)->some View{
        if card.isFaceUp || !card.isMatched{
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    }else{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }.padding(5).opacity(0.5)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ?360:0))
                    //.animation(card.isMatched ?Animation.linear(duration: 1).repeatForever(autoreverses: false):.default)
                    .animation(card.isMatched ?Animation.linear(duration: 1).repeatCount(1, autoreverses: false):.default)
            }
            //.modifier(Cardify(isFaceUp: card.isFaceUp))
            .cardify(isFaceUp:card.isFaceUp)
            //.transition(AnyTransition.scale)
            //.rotation3DEffect(Angle.degrees(card.isFaceUp ?0:180), axis: (0,1,0))
        } else {//card matched (and face down)
            Text(card.content)
            .font(Font.system(size: fontSize(for: size)))
            .cardify(isFaceUp: true)
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
