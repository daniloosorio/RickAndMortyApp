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
        .statusBar(hidden: !showStatusBar)
        .alert(isPresented: $viewModel.hasError){
            Alert(title: Text("Important Message"),
                  message: Text(viewModel.viewError?.localizedDescription ?? "Unexpected errir is happen"),
                  dismissButton: .default(Text("Go it!")))
        }.sheet(isPresented: $showDetail, content: {
            CharacterDetailPage(character: selectedCharacter)
        }
        )
    }
    
    var scrollView: some View {
        ScrollView(){
            scrollDetectionView
            characterListView
                .padding(.vertical,70)
                .padding(.bottom,50)
        }.coordinateSpace(.named("scroll"))
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }.onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation (.easeInOut){
                let estimatedcontentHeight = CGFloat(viewModel.characterList.count * 100)
                let threshold = 0.8 * estimatedcontentHeight
                
                if value <= -threshold {
                    Task {
                        await viewModel.loadCharacterList()
                    }
                }
                contentHasScrolled = value < 0
            }
        }
    }
    
    var characterListView: some View {
        VStack(spacing:16){
            ForEach(Array(viewModel.characterList.enumerated()),id: \.offset){ index, businessModel in
                SectionRowView(section: SectionRowModel(businessModel: businessModel))
                    .onTapGesture {
                        selectedCharacter = businessModel
                        showDetail = true
                    }
                if index != viewModel.characterList.count - 1 {
                    Divider()
                    if viewModel.isLoading {
                        ProgressView("Loading more charaters ...")
                            .accentColor(.white)
                    }
                }else {
                    Divider()
                }
                
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal,20)
    }
}
