//
//  Manga.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import SwiftUI

struct Manga: Hashable, Identifiable, Codable {    
    let id: Int
    let title: String
    let titleJapanese: String?
    let score: Double
    let mainPicture: String
    let chapters: Int?
    let volumes: Int?
    let status: MangaStatus
    let sypnosis: String?
    let startDate: Date?
    let endDate: Date?
    let url: String
    let authors: [Author]
    let demographics: [Demographic]
    let genres: [Genre]
    let themes: [Theme]
    var inCollection: Bool
    var ownedVolumes: Set<Int>
    var readingVolume: Int
    var completeCollection: Bool
    
    //    let tomosComprados: Int?
    //    let tomoLectura: Int?
    
//    var authorsString: String {
//        let authorsCollection = authors.map{"\($0.firstName) \($0.lastName)"}
//        return authorsCollection.formatted(.list(type: .and))
//    }
}

extension Manga {
    var urlPicture: URL {
        URL(string: mainPicture.trimmingCharacters(in: CharacterSet(charactersIn: "\"")))!
    }
    
    var score1Fraction: String {
        score.formatted(.number.precision(.fractionLength(1)))
    }
    
    var scoreColor: Color {
        switch score {
        case 6.5...10:
                .green
        case 5..<6.5:
                .yellow
        case 0..<5:
                .red
        default:
                .green
        }
    }
}

struct Author: Hashable, Identifiable, Codable {
    let role: AuthorRoles
    let lastName: String
    let id: String
    let firstName: String
}

struct Demographic: Hashable, Identifiable, Codable {
    let demographic: MangaDemographics
    let id: String
}

struct Genre: Hashable, Identifiable, Codable {
    let genre: MangaGenres
    let id: String
}

struct Theme: Hashable, Identifiable, Codable {
    let theme: MangaThemes
    let id: String
}

extension Author {
    var fullName: String {
        if !firstName.isEmpty {
            return "\(lastName), \(firstName)"
        }
        return lastName
    }
}
