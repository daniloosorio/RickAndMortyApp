//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 27/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = NavigationBarModel()
    
    
    var body: some View {
        HomePage(viewModel: HomePageViewModel())
            .environmentObject(model)
    }
}

#Preview {
    ContentView()
}
