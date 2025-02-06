//
//  HomePage.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 4/02/25.
//

import SwiftUI
import Observation

struct HomePage: View {
    @EnvironmentObject var router: Router
    @Bindable var viewModel: HomePageViewModel
    
    @State var showStatusBar = true
    @State var contentHasScrolled: Bool = false
    @State var showNav = false
    @State var showDetail: Bool = false
    @State var selectedCharacter: CharacterBusinessModel?
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            scrollView
        }.onChange(of: showDetail){
            withAnimation{
                showNav.toggle()
                showStatusBar.toggle()
            }
        }.overlay(NavigationBarView(title:"Characters",
                                    contentHasScrolled: $contentHasScrolled)
                )
    }
    
    var scrollView: some View {
        ScrollView(){
            
        }
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)}
    }
        .onPreferenceChange(ScrollPreferenceKey.self) { newValue in
            withAnimation (.easeInOut){
                let estimatedcontentHeight: CGFloat(viewModel.characterList.count * 100)
                let threshold = 0.8 * estimatedcontentHeight
                
                if value <= -threshold {
                    Task {
                        await viewModel.loadCharacterList()
                    }
                }
                if value < 0 {
                    contentHasScrolled = true
                    }
                else {
                    contentHasScrolled = false

                }
            }
        }
}
