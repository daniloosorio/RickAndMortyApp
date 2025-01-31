//
//  FakeApiService.swift
//  RickAndMortyAppTests
//
//  Created by Danilo Osorio on 30/01/25.
//

import Foundation
@testable import RickAndMortyApp

class CharacterListFakeApiServiceSuccess: ApiService {
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response {
        do{
            let json = CharacterListFake.makeCharacterListJsonFake()
            let decodeData = try JSONDecoder().decode(Response.self, from: json)
            return decodeData
        }catch{
            if (error as? DecodingError) != nil {
                throw AppError.parseError
            }
            throw AppError.serviceError(error: error)
        }
    }
}

class CharacterListFakeApiServiceFailure: ApiService {
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response {
        throw AppError.missingData
    }
}

class CharacterListFakeApiServiceParseError: ApiService {
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response {
        do {
            let json = CharacterListFake.makeCharacterListJsonFakeParseError()
            let decodeData = try JSONDecoder().decode(Response.self, from: json)
            return decodeData
        } catch {
            if (error as? DecodingError) != nil {
                throw AppError.parseError
            }
            throw AppError.serviceError(error: error)
        }
    }
}
