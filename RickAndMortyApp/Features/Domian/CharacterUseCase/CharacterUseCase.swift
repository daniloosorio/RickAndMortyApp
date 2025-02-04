//
//  CharacterUseCase.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 30/01/25.
//

import Foundation

protocol CharacterUseCase {
    func getCharactersList(pageNumber:String?) async throws -> CharacterListBusinessModel
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListBusinessModel
}

class DefaultCharacterUseCase: CharacterUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = DefaultCharacterRepository()) {
        self.repository = repository
    }
    
    func getCharactersList(pageNumber: String?) async throws -> CharacterListBusinessModel {
        do {
            let response = try await repository.getCharacterList(pageNumber: pageNumber)
            return CharacterListBusinessModel(response: response)
        }catch{
            throw error
        }
    }
    
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListBusinessModel {
        do {
            let response = try await repository.searchCharacter(by: name, and: pageNumber)
            return CharacterListBusinessModel(response: response)
        }catch{
            throw error
        }
    }
}
