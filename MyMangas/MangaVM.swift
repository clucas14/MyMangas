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
    @Published var searchText = "" {
        willSet {
            page = 1
            //            mangas.removeAll() // No funciona bien, cuando cambias de vista lo borra también
        }
    }
    @Published var sortType: SortType = .genres
    @Published var sortOption = "" {
        willSet {
            page = 1
            Task {
                await sortedMangasByGenre(sortType: sortType.rawValue, sortOption: newValue)
            }
        }
    }
    
    var page = 1
    // Hay que calcular el total de páginas para que no pueda hacer una llamada a getmangas de una página que no existe
    //    Hacer que la búsqueda tenga un sleep
    //    Ver temas filtros
    
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
            //            Mostrar error en pantalla, ver foto
        } catch {
            print(error)
        }
    }
    
    func isLastItem(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    func loadNextPage(manga: Manga) {
        if isLastItem(manga: manga) {
            page += 1
            Task {
                await searchText.isEmpty ? getMangas() : searchMangas()
            }
        }
    }
    
    func searchMangas() async {
        if !searchText.isEmpty {
            do {
                // Si es la primera búsqueda vaciamos el array de mangas
                if page == 1 {
                    await MainActor.run {
                        mangas.removeAll()
                    }
                }
                //                try await Task.sleep(nanoseconds: 600)
                let mangs = try await mangaInteractor.searchMangas(page: page, searchString: searchText)
                await MainActor.run {
                    self.mangas += mangs
                }
            } catch {
                print(error)
            }
            //            Darle una vuelta al else
        } else {
            await MainActor.run {
                mangas.removeAll()
            }
            page = 1
            Task {
                await getMangas()
            }
        }
    }
    
    func sortedMangasByGenre(sortType: String, sortOption: String) async {
        do {
            print("SortType es: \(sortType)")
            print("SortOption es: \(sortOption)")
            let mangs = try await mangaInteractor.getMangasByGenre(page: page, sortType: sortType, sortOption: sortOption)
            await MainActor.run {
                self.mangas += mangs
            }
        } catch {
            print(error)
        }
    }
}
