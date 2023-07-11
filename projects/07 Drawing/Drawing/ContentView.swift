//
//  ContentView.swift
//  Drawing
//
//  Created by Matthew Simo on 7/10/23.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    var angle = 0.0
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(Double(insetAmount), Double(angle)) }
        set {
            insetAmount = newValue.first
            angle = newValue.second
        }
        
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        

        let rotation = CGAffineTransform(rotationAngle: angle * Double.pi / 180)
        let position = CGAffineTransform(translationX: -rect.maxX / 2, y: -rect.maxY / 2)
        let offset = CGAffineTransform(translationX: rect.maxX / 2, y: rect.maxY / 2)
        
        let adjustment = position.concatenating(rotation).concatenating(offset)
        
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - rect.width * 0.25, y: rect.minY + rect.height * 0.25))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + rect.width * 0.25, y: rect.minY + rect.height * 0.25))
        
        
        return path.applying(adjustment)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}


struct ContentView: View {
    @State private var lineThickness = 1.0
    @State private var hue = 0.0
    @State private var angle = 0.0
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Arrow(angle:angle)
                .strokeBorder(Color(hue: hue, saturation: 1, brightness: 1), style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300, alignment: .center)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2)) {
                        angle = Double.random(in: 0...360)
                        lineThickness = Double(Int.random(in: 1...30))
                    }
                }
            
            Spacer()
            
            Text("Line Thickness: \(lineThickness.formatted())")
            Slider(value: $lineThickness, in: 1...30, step: 1)
                .padding([.horizontal, .bottom])
            
            
            Text("Hue:")
            Slider(value: $hue, in: 0...1)
                .padding([.horizontal, .bottom])
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
