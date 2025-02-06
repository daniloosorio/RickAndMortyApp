//
//  AnimationFontModifier.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 5/02/25.
//

import SwiftUI

struct AnimationFontModifier: AnimatableModifier{
    var size : Double
    var wight: Font.Weight = .regular
    var design: Font.Design = .default
    
    var animatableData: Double {
        get {size}
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: wight, design: design))
    }
}

extension View {
    func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimationFontModifier(size: size, wight: weight, design: design))
    }
}
