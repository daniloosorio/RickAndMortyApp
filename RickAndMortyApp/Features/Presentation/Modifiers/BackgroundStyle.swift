//
//  BackgroundStyle.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 5/02/25.
//

import SwiftUI

struct BackgroundStyle: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.6
    
    func body(content: Content)-> some View {
        content
            .backgroundColor(opacity : opacity)
            .cornerRadius(cornerRadius)
            .shadow(color: Color(.shadow).opacity(0),radius:20,x:0,y:10)
            .modifier(OutlineOverlay(cornerRadius: cornerRadius))
    }
}

extension View {
    func backgroundStyle(cornerRadius: CGFloat=20, opacity: Double = 0.6)-> some View {
        self.modifier(BackgroundStyle(cornerRadius: cornerRadius, opacity: opacity))
    }
}

struct OutlineOverlay: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.linearGradient(colors: [
                        .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                        .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                    ], startPoint: .top, endPoint: .bottom)
                    ).blendMode(.overlay)
            )
    }
}
