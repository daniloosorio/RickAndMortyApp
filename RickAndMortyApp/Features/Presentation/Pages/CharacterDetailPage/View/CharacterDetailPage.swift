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
            imageView
            detailView
        }
        .toolbar(.visible,for: .navigationBar)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
    
    var imageView: some View {
        Group {
            if let character,
               let url = URL(string: character.image){
                AsyncImageView(url: url)
                    
            }else{
                Image("noImageAvailable")
            }
        }.overlay(alignment: .top, content: {closeButtonView}).frame(height: 400)
    }
    var closeButtonView: some View {
        ZStack{
            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial,in:Circle())
                    .backgroundStyle(cornerRadius: 18)
            })
            .padding(15)
            .padding(.top)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
        }
        .animation(.snappy, value: true)
    }
    
    var detailView: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack{
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY: 500)
            .overlay(
                VStack(alignment: .leading, spacing: 16){
                    Text(character?.name ?? "")
                        .font(.title).bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundColor(.primary)
                    
                    Divider()
                        .foregroundColor(.secondary)
                    
                    if let status = character?.status?.rawValue {
                        
                        Text("Status: \(String(describing: status))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Divider()
                            .foregroundColor(.secondary)
                    }
                    
                    if let species = character?.species {
                        Text("Species: \(String(describing: species))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Divider().foregroundColor(.secondary)
                    }
                    
                    if let type = character?.type, !type.isEmpty {
                        Text("Type: \(String(describing: type))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Divider()
                            .foregroundStyle(.secondary)
                    }
                    
                    if let gender = character?.gender?.rawValue {
                        Text("Gender: \(String(describing: gender))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundStyle(.primary.opacity(0.7))
                        
                        Divider().foregroundColor(.secondary)
                    }
                    
                    if let origin = character?.origin.name {
                        Text("Origin: \(String(describing: origin))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Divider().foregroundColor(.secondary)
                    }
                    
                    if let location = character?.location.name {
                        Text("Location: \(String(describing: location))".uppercased())
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Divider().foregroundColor(.secondary)
                    }
                    
                    if let listOfEpisodes = character?.listOfEpisodes {
                        Text("Episodes:")
                            .font(.footnote).bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                        Text(listOfEpisodes)
                            .font(.footnote)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.primary.opacity(0.7))
                    }
                }
                    .padding(20)
                    .padding(.vertical,10)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(maxWidth: .infinity,alignment: .bottom)
                            .cornerRadius(30)
                            .blur(radius: 30)
                    )
                    .background(Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
                    ).offset(y: scrollY > 0 ? -scrollY * 1.8 : 0 )
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .offset(y: 200)
                    .padding(20)
            )
        }
        .frame(height: 500)
    }
}
