//
//  Model.swift
//  SuperheroRandomizerApp
//
//  Created by Nurken on 28.11.2024.
//

import Foundation

struct SuperHero: Codable{
    let id: Int
    let name: String
    let powerstats: Powerstats
    let biography: Biography
    let images: Image
}

struct Powerstats: Codable{
    let intelligence: Int
    let power: Int
    let speed: Int
    let durability: Int
    let combat: Int
}

struct Biography: Codable{
    let fullName: String
    let alterEgos: String
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String
}

struct Image: Codable{
    let md: String
    let lg: String
    
}
