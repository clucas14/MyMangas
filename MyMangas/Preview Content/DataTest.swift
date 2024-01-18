//
//  DataTest.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import Foundation

extension Manga {
    static let test = Manga(id: 1245,
                            title: "Berserk", 
                            titleJapanese: "ベルセルク",
                            score: 9.47,
                            mainPicture: "\"https://cdn.myanimelist.net/images/manga/3/76401l.jpg\"",
                            chapters: nil,
                            volumes: 5,
                            status: .finished,
                            sypnosis: "Guts, a former mercenary now known as the \"Black Swordsman,\" is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype",
                            startDate: Date.now,
                            endDate: nil,
                            url: "\"https://myanimelist.net/manga/2/Berserk\"", 
                            authors: [Author(role: .storyArt, lastName: "Miura", id: "6F0B6948-08C4-4761-8BE1-192E68AB0A2F", firstName: "Kentarou"), Author(role: .art, lastName: "Studio Gaga", id: "0304C4E9-2D89-463A-8FDD-EEAB5B9D57B3", firstName: "")],
                            demographics: [],
                            genres: [],
                            themes: [],
                            inCollection: true,
                            ownedVolumes: [1,3],
                            readingVolume: 1,
                            completeCollection: false)
}

extension MangaVM {
    static let test = MangaVM(network: DataTest())
}

struct DataTest: MangaNetworkInteractorProtocol {
    let url = Bundle.main.url(forResource: "testMangas", withExtension: ".json")!
    
    func getMangas(page: Int) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([DTOManga].self, from: data).map(\.toPresentation)
    }
    
//    HAY QUE MODIFICARLA!!!!
    func searchMangas(page: Int, searchString: String) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([DTOManga].self, from: data).map(\.toPresentation)
    }
    
    //    HAY QUE MODIFICARLA!!!!
    func getMangasByGenre(page: Int, sortOption: String) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([DTOManga].self, from: data).map(\.toPresentation)
    }
    
    //    HAY QUE MODIFICARLA!!!!
    func getMangasByTheme(page: Int, sortOption: String) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([DTOManga].self, from: data).map(\.toPresentation)
    }
    
    //    HAY QUE MODIFICARLA!!!!
    func getMangasByDemographic(page: Int, sortOption: String) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        
        let data = try Data(contentsOf: url)
        return try decoder.decode([DTOManga].self, from: data).map(\.toPresentation)
    }
}
