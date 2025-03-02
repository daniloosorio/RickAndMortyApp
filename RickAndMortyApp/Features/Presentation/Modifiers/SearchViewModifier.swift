//
//  SearchViewModifier.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 11/02/25.
//

import SwiftUI

struct SearchViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 30)
            .padding(20)
            .navigationTitle("Search")
            .background(
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 200)
                    .frame(maxHeight: .infinity,alignment: .top)
                    .offset(y:-200)
                    .blur(radius: 20)
            )
            .background(
                Image("Blob 1").offset(x: -100,y: -200)
                    .accessibility(hidden: true)
            )
            
    }
}

extension View {
    func searchViewStyle() -> some View {
        self.modifier(SearchViewModifier())
    }
}
