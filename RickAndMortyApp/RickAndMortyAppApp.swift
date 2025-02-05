//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 27/01/25.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navStack){
                ContentView()
            }.environmentObject(router)
        }
    }
}
