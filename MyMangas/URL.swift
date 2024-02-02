//
//  URL.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

extension URL {
    static let getMangasURL = mainURL.appending(path: "list/mangas")
    static let getAuthorsURL = mainURL.appending(path: "list/authors")
    static let searchMangasURL = mainURL.appending(path: "search/mangasContains")
    static let getMangasByGenreURL = mainURL.appending(path: "list/mangaByGenre")
    static let getMangasByThemeURL = mainURL.appending(path: "list/mangaByTheme")
    static let getMangasByDemographicURL = mainURL.appending(path: "list/mangaByDemographic")
    static let getMangasByAuthorURL = mainURL.appending(path: "list/mangaByAuthor")
}
