//
//  ScrollPreferenceKey.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 6/02/25.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
