//
//  MangaEditVM.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import SwiftUI

final class MangaEditVM: ObservableObject {
    
    @Published var ownedVolumes: Set<Int>
    @Published var readingVolume: Int
    @Published var completeCollection: Bool
    
    @Published var manga: Manga
    
    @Published var msg = ""
    @Published var showAlert = false
    
    @Published var showSelectAll = true
    
    var sortOwnedVolumes: [Int] {
        ownedVolumes.sorted()
    }
    
    var listOwnedVolumes: String {
        if !ownedVolumes.isEmpty {
            let ownedVolumesString = ownedVolumes.sorted().map { "\($0)" }
            return ownedVolumesString.formatted(.list(type: .and))
        } else {
            return "There are none selected"
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
    
    func allSlectionVolume() {
        if let volumes = manga.volumes {
            for volume in 1...volumes {
                if !ownedVolumes.contains(volume) {
                    ownedVolumes.insert(volume)
                }
            }
            showSelectAll.toggle()
        }
    }
    
    func removeAllSlectionVolume() {
        if let volumes = manga.volumes {
            for volume in 1...volumes {
                if ownedVolumes.contains(volume) {
                    ownedVolumes.remove(volume)
                }
            }
            showSelectAll.toggle()
        }
    }
    
    func saveEditManga() -> Manga {
        Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: manga.inCollection, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
    }
    
    func validateManga() -> Manga? {
        var message = ""
        
        if  ownedVolumes.count == 0 && manga.volumes != nil {
            message += "You must select at least one volume.\n"
        }
        if completeCollection == true {
            if ownedVolumes.count != manga.volumes && manga.volumes != nil {
                message += "You do not have all the volumes selected and therefore cannot have the complete collection.\n"
            } else {
                switch manga.status {
                case .currentlyPublishing:
                    message += "The collection cannot be marked as complete as the manga is currently in publication and is not finished.\n"
                case .finished:
                    return saveEditManga()
                case .onHiatus:
                    message += "The collection cannot be marked as complete as the manga publication is paused and is not finalized.\n"
                case .discontinued:
                    return saveEditManga()
                }
            }
        }
        if message.isEmpty {
            return saveEditManga()
        } else {
            self.msg = String(message.dropLast())
            self.showAlert.toggle()
            return nil
        }
    }
}
