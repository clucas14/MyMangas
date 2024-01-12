//
//  MangaEditVM.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import Foundation

final class MangaEditVM: ObservableObject {
    
    @Published var ownedVolumes: Set<Int>
    @Published var readingVolume: Int
    @Published var completeCollection: Bool
    
    var manga: Manga
    
    var sortOwnedVolumes: [Int] {
        ownedVolumes.sorted()
    }
    
    var listOwnedVolumes: String {
        if !ownedVolumes.isEmpty {
            let ownedVolumesString = ownedVolumes.sorted().map { "\($0)" }
            return ownedVolumesString.formatted(.list(type: .and).locale(Locale(identifier: "es")))
        } else {
            return "No hay ninguno seleccionado"
        }
    }
    
    init(manga: Manga) {
        self.manga = manga
        ownedVolumes = manga.ownedVolumes
        readingVolume = manga.readingVolume
        completeCollection = manga.completeCollection
    }
    
    func toggleSelectionVolume(volume: Int){
            if ownedVolumes.contains(volume) {
                ownedVolumes.remove(volume)
            } else {
                ownedVolumes.insert(volume)
            }
        }

    func saveEditManga() -> Manga {
        Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: true, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
    }
}
