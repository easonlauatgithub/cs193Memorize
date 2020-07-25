//
//  Pie.swift
//  cs193Memorize
//
//  Created by Eason on 24/7/2020.
//  Copyright © 2020 cs193p. All rights reserved.
//

import Foundation
import SwiftUI

struct Pie:Shape{
    var startAngle:Angle
    var endAngle:Angle
    var clockwise:Bool = false
    var animatableData: AnimatablePair<Double,Double>{
        get{ AnimatablePair(startAngle.radians, endAngle.radians) }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    func path(in rect:CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x:center.x + radius * cos(CGFloat(startAngle.radians)),
            y:center.x + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
