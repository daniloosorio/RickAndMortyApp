//
//  HomePageViewModel.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 4/02/25.
//

import Foundation
import Observation

@Observable class HomePageViewModel {
    private let useCase: CharacterUseCase
    
    var characterList: [CharacterBusinessModel] = []
    var viewError: AppError?
    var hasError: Bool = false
    var isLoading: Bool = false
    private var currentPage: Int = 1
    
    init(useCase: CharacterUseCase = DefaultCharacterUseCase()) {
        self.useCase = useCase
    }
    
    func loadCharacterList() async{
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let response = try await useCase.getCharactersList(pageNumber: "\(currentPage)")
            
            //update ui in the main thread
            await MainActor.run {
                characterList += response.results
                hasError = false
                currentPage += 1
                isLoading = false
            }
        } catch {
            //handle error update ui in main thread
            await MainActor.run {
                isLoading = false
                viewError = .unExpectedError
                hasError = true
            }
            
            
        }
    }
    
}
