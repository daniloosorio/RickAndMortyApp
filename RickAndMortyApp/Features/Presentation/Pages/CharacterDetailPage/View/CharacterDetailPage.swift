//
//  CharacterDetailPage.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 6/02/25.
//

import SwiftUI

struct CharacterDetailPage: View {
    @Environment(\.presentationMode) var presentationMode
    
    var character: CharacterBusinessModel?
    
    var body: some View {
        ScrollView {
            
        }
        .toolbar(.visible,for: .navigationBar)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetailPage()
}
