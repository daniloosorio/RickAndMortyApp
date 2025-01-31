//
//  CharacterUseCase.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 30/01/25.
//

import Foundation

protocol CharacterUseCase {
    func getCharacters(pageNumber:String?) async throws -> !!
    func searchCharacters(by name: String, and pageNumber: String?) async throws -> !!
}

class DefaultCharacterUseCase: CharacterUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = DefaultCharacterRepository()) {
        self.repository = repository
    }
}
