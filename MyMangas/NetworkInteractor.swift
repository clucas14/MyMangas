//
//  MangaInteractor.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

protocol MangaNetworkInteractorProtocol {
    func getMangas(page: Int) async throws -> [Manga]
    func getAuthors() async throws -> [Author]
    func searchMangas(page: Int, searchString: String) async throws -> [Manga]
    func getMangasByGenre(page: Int, sortOption: String) async throws -> [Manga]
    func getMangasByTheme(page: Int, sortOption: String) async throws -> [Manga]
    func getMangasByDemographic(page: Int, sortOption: String) async throws -> [Manga]
    func getMangasByAuthor(page: Int, sortOption: String) async throws -> [Manga]
}

struct NetworkInteractor: MangaNetworkInteractorProtocol {
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        if response.statusCode == 200 {
            do {
                return try decoder.decode(type.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func getMangas(page: Int) async throws -> [Manga] {
//        try await getJSON(request: .getPaginateMangas(url: .getMangasURL, page: page), type: DTOMangasResult.self).items.map(\.toPresentation)
        try await getJSON(request: .get(url: .getMangasURL, page: page), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getAuthors() async throws -> [Author] {
        try await getJSON(request: .getAuthors(url: .getAuthorsURL), type: Authors.self).map(\.toPresentation)
    }
    
    func searchMangas(page: Int, searchString: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .searchMangasURL, page: page, string: searchString), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getMangasByGenre(page: Int, sortOption: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangasByGenreURL, page: page, string: sortOption), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getMangasByTheme(page: Int, sortOption: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangasByThemeURL, page: page, string: sortOption), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getMangasByDemographic(page: Int, sortOption: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangasByDemographicURL, page: page, string: sortOption), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getMangasByAuthor(page: Int, sortOption: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangasByAuthorURL, page: page, string: sortOption), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
}
