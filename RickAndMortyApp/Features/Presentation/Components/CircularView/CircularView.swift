//
//  CircularView.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 6/02/25.
//

import SwiftUI

struct CircularView: View {
    var value: CGFloat = 0.5
    var lineWidth: Double = 4
    
    @State var appear = false
    var body: some View {
        Circle()
            .trim(from:0, to: appear ? value : 0)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .fill(.angularGradient(colors: [.purple,.orange,.purple], center: .center, startAngle: .degrees(0), endAngle: Angle(degrees: 360)))
            .rotationEffect(.degrees(270))
            .onAppear{
                withAnimation(.spring.delay(0.5)){
                    appear = true
                }
            }
            .onDisappear{
                appear = false
            }
    }
}
