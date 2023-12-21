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
