//
//  MangaViewModel.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import Foundation

final class MangaVM: ObservableObject {
    let mangaInteractor: MangaInteractorProtocol
    
    @Published var mangas: [Manga] = []
    
    var page = 1
    
    @Published var searchText = ""
    
    init(network: MangaInteractorProtocol = Network()) {
        self.mangaInteractor = network
        Task {
            await getMangas()
        }
    }
    
    func getMangas() async {
        do {
            let mangs = try await mangaInteractor.getMangas(page: page)
            await MainActor.run {
                self.mangas += mangs
            }
//            Mostrar error en pantalla
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isLastItem(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    func loadNextPage(manga: Manga) {
        if isLastItem(manga: manga) {
            page += 1
            Task {
                await getMangas()
            }
        }
    }
}
