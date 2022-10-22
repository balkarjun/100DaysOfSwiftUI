//
//  ContentView.swift
//  P09-Drawing
//
//  Created by Arjun B on 22/10/22.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Arc(startAngle: .degrees(-60), endAngle: .degrees(60), clockwise: true)
                    .strokeBorder(.blue.gradient.opacity(0.1), style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                    .frame(width: 300)
                
                Arc(startAngle: .degrees(-60), endAngle: .degrees(20), clockwise: true)
                    .strokeBorder(.blue.gradient, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                    .frame(width: 300)
                
                Triangle()
                    .stroke(.red.gradient, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .frame(width: 50, height: 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
