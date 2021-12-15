//
//  DogModel.swift
//  LystProject
//
//

import Foundation

struct DogModel: Codable {
    let id: Int?
    let name: String?
    let temperament: String?
    let origin: String?
    let bredFor: String?
    let breedGroup: String?
    var image: Image?
    let weight: DogMeasurement?
    let height: DogMeasurement?
    let wikipediaURL: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case image
        case weight
        case height
        case wikipediaURL = "wikipedia_url"
    }
}

struct DogMeasurement: Codable {
    let imperial: String?
    let metric: String?
    
    enum CodingKeys: String, CodingKey {
        case imperial
        case metric
    }
}

struct Image: Codable {
    let id: String?
    let width, height: Int?
    let url: String?
}
