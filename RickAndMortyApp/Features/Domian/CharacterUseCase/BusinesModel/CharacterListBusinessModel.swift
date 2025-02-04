//
//  CharacterListBusinessModel.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 30/01/25.
//

import Foundation
// MARK: - CharacterListBusinessModel
struct CharacterListBusinessModel{
    let info :InfoBusinessModel
    let results:[CharacterBusinessModel]
    init(response: CharacterListResponse){
        info = InfoBusinessModel(next: response.info.next ?? "",
                                 prev: response.info.prev ?? "")
        results = response.results.map({response in
            CharacterBusinessModel(response:response)
        })
    }
}

// MARK: - Info
struct InfoBusinessModel {
    let next, prev: String?
    init(next: String?, prev: String?) {
        self.next = next
        self.prev = prev
    }
}

// MARK: - Result
struct CharacterBusinessModel {
    let id: Int
    let name: String
    let status: StatusBusinessModel?
    let species, type: String
    let gender: GenderBusineesModel?
    let origin, location: LocationBusinessModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var listOfEpisodes: String {
        episode.compactMap {URL(string: $0)?.lastPathComponent}.joined(separator: ", ")
    }
    
    init(response: CharacterResponse){
        id = response.id
        name = response.name
        status = StatusBusinessModel(rawValue: response.status.rawValue)
        species = response.species
        type = response.type
        gender = GenderBusineesModel(rawValue: response.gender.rawValue)
        origin = LocationBusinessModel(response: response.origin)
        location = LocationBusinessModel(response: response.location)
        image = response.image
        episode = response.episode
        url = response.url
        created = response.created
    }
}

enum GenderBusineesModel: String {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationBusinessModel {
    let name: String
    let url: String
    
    init(response: LocationResponse){
        self.name = response.name
        self.url = response.url
    }
}

enum StatusBusinessModel: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
