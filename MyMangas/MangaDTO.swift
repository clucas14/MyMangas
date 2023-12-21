//
//  Manga.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

struct MangasResultDTO: Codable {
    let metadata: Metadata
    let items: [MangaDTO]
}

struct Metadata: Codable {
    let per: Int
    let total: Int
    let page: Int
}

struct MangaDTO: Codable {
    let id: Int
    let tittle: String
    let score: Double
    let mainPicture: String
    let chapters: Int
    let volumes: Int
    let status: String
    let sypnosis: String
    let startDate: String
    let endDate: String
    let url: String
    let demographics: [Demographic]
    let genres: [Genre]
    let authors: [Author]
    let themes: [Theme]
}

struct Demographic: Codable {
    let demographic: String
    let id: String
}

struct Genre: Codable {
    let genre: String
    let id: String
}

struct Author: Codable {
    let role: String
    let lastName: String
    let id: String
    let firstName: String
}

struct Theme: Codable {
    let theme: String
    let id: String
}
