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

//    func saveEditManga() -> Manga {
//        Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: true, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
//    }
    
    func validateManga() -> Manga? {
        var message = ""
        
        if  ownedVolumes.count == 0 && manga.volumes != nil {
            message += "Debes seleccionar al menos un volumen.\n"
        }
        if completeCollection == true {
            if ownedVolumes.count != manga.volumes && manga.volumes != nil {
                message += "No tienes todos los volúmenes seleccionados y por tanto no puedes tener la colección completa.\n"
            } else {
                switch manga.status {
                case .currentlyPublishing:
                    message += "No se puede marcar como completa la colección ya que el manga está actualmente en publicación y no está finalizado.\n"
                case .finished:
                    manga = Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: manga.inCollection, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
                    return manga
                case .onHiatus:
                    message += "No se puede marcar como completa la colección ya que la publicación del manga está pausada y no está finalizada.\n"
                case .discontinued:
                    manga = Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: manga.inCollection, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
                    return manga
                }
            }
        }
        if message.isEmpty {
            manga = Manga(id: manga.id, title: manga.title, titleJapanese: manga.titleJapanese, score: manga.score, mainPicture: manga.mainPicture, chapters: manga.chapters, volumes: manga.volumes, status: manga.status, sypnosis: manga.sypnosis, startDate: manga.startDate, endDate: manga.endDate, url: manga.url, authors: manga.authors, demographics: manga.demographics, genres: manga.genres, themes: manga.themes, inCollection: manga.inCollection, ownedVolumes: ownedVolumes, readingVolume: readingVolume, completeCollection: completeCollection)
            return manga
        } else {
            self.msg = String(message.dropLast())
            self.showAlert.toggle()
            return nil
        }
    }
}
