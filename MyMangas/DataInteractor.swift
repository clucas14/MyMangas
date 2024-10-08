//
//  DataDataInteractor.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 12/1/24.
//

import Foundation

protocol DataInteractor {
    var urlBundle: URL { get }
    var docURL: URL { get }
    
    func loadData<T>() throws -> T where T: Codable
    func saveData<T>(json: T) throws where T: Codable
}

extension DataInteractor {
    func loadData<T>() throws -> T where T: Codable {
        var url = docURL
        if !FileManager.default.fileExists(atPath: url.path()) {
            url = urlBundle
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)  
    }
    
    func saveData<T>(json: T) throws where T: Codable {
        let data = try JSONEncoder().encode(json)
        try data.write(to: docURL, options: .atomic)
    }
}

struct MangaDataInteractor: DataInteractor {
    let urlBundle = Bundle.main.url(forResource: "mangacollection", withExtension: "json")!
    let docURL = URL.documentsDirectory.appending(path: "mangacollection.json")
}

