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

struct AuthorDTO: Codable {
    let role: AuthorRoles
    let lastName: String
    let id: String
    let firstName: String
    
    var toPresentation: Author {
        Author(role: role, 
               lastName: lastName,
               id: id,
               firstName: firstName)
    }
}

struct DemographicDTO: Codable {
    let demographic: MangaDemographics
    let id: String
    
    var toPresentation: Demographic {
        Demographic(demographic: demographic,
                    id: id)
    }
}

struct GenreDTO: Codable {
    let genre: MangaGenres
    let id: String
    
    var toPresentation: Genre {
        Genre(genre: genre,
              id: id)
    }
}

struct ThemeDTO: Codable {
    let theme: MangaThemes
    let id: String
    
    var toPresentation: Theme {
        Theme(theme: theme,
              id: id)
    }
}

struct DTOManga: Codable {
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
    let authors: [AuthorDTO]
    let demographics: [DemographicDTO]
    let genres: [GenreDTO]
    let themes: [ThemeDTO]
}

extension DTOManga {
    var toPresentation: Manga {
        Manga(id: id,
              title: title, 
              titleJapanese: titleJapanese,
              score: score,
              mainPicture: mainPicture,
              chapters: chapters,
              volumes: volumes,
              status: status,
              sypnosis: sypnosis,
              startDate: startDate,
              endDate: endDate,
              url: url,
              authors: authors.map(\.toPresentation),
              demographics: demographics.map(\.toPresentation),
              genres: genres.map(\.toPresentation),
              themes: themes.map(\.toPresentation), 
              inCollection: false,
              ownedVolumes: [],
              readingVolume: 0, 
              completeCollection: false)
    }
}
