//
//  MangaEditVM.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import Foundation

final class MangaEditVM: ObservableObject {
    
    var manga: Manga
    
    
    init(manga: Manga) {
        self.manga = manga
    }
    
    func toggleSelectionVolume(volume: Int){
            if manga.ownedVolumes.contains(volume) {
                manga.ownedVolumes.remove(volume)
            } else {
                manga.ownedVolumes.insert(volume)
            }
        }
//    }
}
