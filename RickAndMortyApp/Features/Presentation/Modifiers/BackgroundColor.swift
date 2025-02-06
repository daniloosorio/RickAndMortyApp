//
//  BackgroundColor.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 5/02/25.
//

import SwiftUI

struct BackgroundColor: ViewModifier {
    var opacity: Double = 0.6
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content)-> some View {
        content
            .overlay(Color(.background)
                .opacity(colorScheme == .dark ? opacity : 0)
                .blendMode(.overlay)
                .allowsHitTesting(false)
            )
    }
}

extension View {
    func backgroundColor(opacity: Double = 0.6)-> some View {
        self.modifier(BackgroundColor(opacity: opacity))
    }
}
