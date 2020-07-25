//
//  Cardify.swift
//  cs193Memorize
//
//  Created by Eason on 24/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//
import SwiftUI

//struct Cardify : ViewModifier, Animatable {
struct Cardify : AnimatableModifier {
    var rotation:Double
    init(isFaceUp:Bool){
        rotation = isFaceUp ?0:180
    }
    var isFaceUp:Bool {
        rotation < 90
    }
    var animatableData: Double{
        get{return rotation}
        set{rotation = newValue}
    }
    
    func body(content:Content)->some View{
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ?1:0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
            .opacity(isFaceUp ?0:1)
            /*
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }else{
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }*/
        }
        //.rotation3DEffect(Angle.degrees(card.isFaceUp ?0:180), axis: (0,1,0))
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    private let cornerRadius:CGFloat = 10.0
    private let edgeLineWidth:CGFloat = 3
}
extension View{
    func cardify(isFaceUp:Bool)->some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

/*
private func body(for size:CGSize)->some View{
    ZStack{
        if card.isFaceUp {
        //if isFaceUp {
            //func fill<S>(_ whatToFillWith:S)->View where S:ShapeStyle
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(90-90), clockwise: true).padding(5).opacity(0.5)
            Text(card.content)
            //Text("👻")
        }else{
            if !card.isMatched{
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }else{
                //matched, make the cards disappear
            }
        }
    }
    //.font(Font.largeTitle)
    .font(Font.system(size: fontSize(for: size)))
}
**/
