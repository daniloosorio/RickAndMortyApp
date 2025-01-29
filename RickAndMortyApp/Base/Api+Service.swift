//
//  Api+Service.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 27/01/25.
//

import Foundation

///interface
protocol ApiService {
    
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response
}

// clase que extiende la interface
class DefaultApiService: ApiService {
    
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response {
        guard let url = URL(string: url) else {
            throw AppError.invalidUrl
        }
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Response.self, from: data)
        }catch {
            if (error as? DecodingError) != nil {
                throw AppError.parseError
            }
            throw AppError.serviceError(error: error)
        }
    }
    
}
