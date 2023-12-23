//
//  Manga.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import SwiftUI

struct Manga: Hashable, Identifiable {
    let id: Int
    let title: String
    let score: Double
    let mainPicture: String
    let chapters: Int?
    let volumes: Int?
    let status: String
    let sypnosis: String?
    let startDate: Date?
    let endDate: Date?
    let url: String
//    let demographics: [MangaDemographics]
//    let genres: [MangaGenres]
//    let authors: [AuthorRoles]
//    let themes: [MangaThemes]
    
    var urlPicture: URL {
        URL(string: mainPicture.trimmingCharacters(in: CharacterSet(charactersIn: "\"")))!
    }
    
    var score1Fraction: String {
        score.formatted(.number.precision(.fractionLength(1)))
    }
    
//Ponerlo como extensión?¿?¿
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
