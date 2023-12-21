//
//  Manga.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

struct DTOMangasResult: Codable {
    let metadata: Metadata
    let items: [DTOManga]
}

struct Metadata: Codable {
    let per: Int
    let total: Int
    let page: Int
}

struct DTOManga: Codable {
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
    
//    struct Demographic: Codable {
//        let demographic: MangaDemographics
//        let id: String
//    }
//    let demographics: [Demographic]
//    
//    struct Genre: Codable {
//        let genre: MangaGenres
//        let id: String
//    }
//    let genres: [Genre]
//    
//    struct Author: Codable {
//        let role: AuthorRoles
//        let lastName: String
//        let id: String
//        let firstName: String
//    }
//    let authors: [Author]
//    
//    struct Theme: Codable {
//        let theme: MangaThemes
//        let id: String
//    }
//    let themes: [Theme]
}

extension DTOManga {
    var toPresentation: Manga {
        Manga(id: id,
              title: title,
              score: score,
              mainPicture: mainPicture,
              chapters: chapters,
              volumes: volumes,
              status: status,
              sypnosis: sypnosis,
              startDate: startDate,
              endDate: endDate,
              url: url)
//              demographics: [demographics.],
//              genres: genres,
//              authors: authors,
//              themes: themes)
    }
}
