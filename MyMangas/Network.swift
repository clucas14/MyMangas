//
//  MangaInteractor.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

protocol MangaInteractorProtocol {
    func getMangas(page: Int) async throws -> [Manga]
    func searchMangas(page: Int, searchString: String) async throws -> [Manga]
    func getMangasByGenre(page: Int, sortType: String, sortOption: String) async throws -> [Manga]
}

struct Network: MangaInteractorProtocol {
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
    
    func searchMangas(page: Int, searchString: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .searchMangasURL, page: page, string: searchString), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
    
    func getMangasByGenre(page: Int, sortType: String, sortOption: String) async throws -> [Manga] {
        try await getJSON(request: .get(url: .getMangasByGenreURL, page: page, string: sortType, sortOption: sortOption), type: DTOMangasResult.self).items.map(\.toPresentation)
    }
}
