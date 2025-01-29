//
//  CharacterListResponse.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 28/01/25.
//

import Foundation

struct CharacterListResponse: Codable {
    let info : InfoResponse
    var results : [CharacterResponse]
    
}

struct InfoResponse: Codable {
    let count,pages: Int
    let next,prev: String?
}
struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let status: StatusResponse
    let species, type: String
    let gender : GenderResponse
    let origin, location: LocationResponse
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
enum GenderResponse: String, Codable {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
}

struct LocationResponse: Codable {
    let name: String
    let url: String
}

enum StatusResponse: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
