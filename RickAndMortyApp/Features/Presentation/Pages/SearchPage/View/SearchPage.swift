//
//  SearchPage.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 11/02/25.
//

import SwiftUI
import Observation

struct SearchPage: View {
    
    @Bindable var viewModel: SearchPageViewModel
    @State var text = ""
    @State var showCharacterDetail = false
    @State var selectedCharacter: CharacterBusinessModel?
    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.characterList.isEmpty{
                    emptyView
                }else{
                    searchView
                }
                Spacer()
            }
            
        }.searchable(text: $text)
            .onChange(of: text){ _, newValue in
                searchCharacter(by:newValue)
            }
    }
    var emptyView: some View {
        Text("No Character Found")
            .searchViewStyle()
    }
    
    var searchView: some View {
        ScrollView {
            scrollDetectionView
            
            ForEach(Array(viewModel.characterList.enumerated()), id: \.offset) { index, character in
                if index != 0 {
                    Divider()
                }
                
                Button {
                    showCharacterDetail = true
                    selectedCharacter = character
                } label: {
                    ListRow(title: character.name, image: character.image)
                    if viewModel.isLoading {
                        ProgressView()
                            .accentColor(.white)
                    }
                }.buttonStyle(.plain)
            }
        }.searchViewStyle()
            .coordinateSpace(.named("scrollview"))
            .sheet(isPresented: $showCharacterDetail){
                CharacterDetailPage(character: selectedCharacter)
            }
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scrollview")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange( ScrollPreferenceKey.self){ value in
            withAnimation(.easeInOut){
                let estimateContentHeight = CGFloat(viewModel.characterList.count*50)
                let threshold = 0.4 * estimateContentHeight
                if value <= -threshold {
                    Task {
                        await viewModel.searchCharacter(by: text, isFirstLoad: false)
                    }
                }
                
            }
            
        }
        
    }
    
}

extension SearchPage {
    private func searchCharacter(by text: String) {
        viewModel.workItem?.cancel()
        let task = DispatchWorkItem { [weak viewModel] in
            guard let viewModel = viewModel else { return }
            Task {
                await viewModel.searchCharacter(by: text, isFirstLoad: true)
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
        viewModel.workItem = task
    }
}
