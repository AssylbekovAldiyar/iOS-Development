
import Foundation

struct SuperHero: Codable {
    let name: String
    let biography: Biography
    let powerstats: Powerstats
    let images: HeroImages
}

struct Biography: Codable {
    let fullName: String
    let alterEgos: String
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String
}

struct Powerstats: Codable {
    let intelligence: Int
    let power: Int
    let speed: Int
    let durability: Int
    let combat: Int
}

struct HeroImages: Codable {
    let md: String
    let lg: String
}
