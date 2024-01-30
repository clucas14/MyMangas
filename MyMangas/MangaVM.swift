//
//  MangaViewModel.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import Foundation

final class MangaVM: ObservableObject {
    let mangaInteractor: MangaNetworkInteractorProtocol
    let mangaDataInteractor: DataInteractor
    
    @Published var mangas: [Manga] = []
    @Published var mangasCollection: [Manga] = [] {
        didSet {
            try? mangaDataInteractor.saveData(json: mangasCollection)
        }
    }
    
    @Published var searchText = "" {
        willSet {
            page = 1
            if sortType != .nofilter {
                sortType = .nofilter
            }
        }
    }
    @Published var sortType: SortType = .nofilter {
        didSet {
            //            if sortType != .nofilter {
            page = 1
            Task {
                await sortedMangasByType(sortOption: sortOption)
            }
            //            }
        }
    }
    @Published var sortOption = ""
//    @Published var searchEmpty = false
    
    //    var myCollection: [Manga] {
    //        mangas.filter { $0.inCollection }
    //    }
    
    var page = 1
    // Hay que calcular el total de páginas para que no pueda hacer una llamada a getmangas de una página que no existe
    
    init(network: MangaNetworkInteractorProtocol = NetworkInteractor(), data: DataInteractor = MangaDataInteractor()) {
        self.mangaInteractor = network
        self.mangaDataInteractor = data
        //       Revisar esto, hay que meter el task en el do?¿ hay que hacerlo con el mostrado de errores
        do {
            mangasCollection = try mangaDataInteractor.loadData()
        } catch {
            print(error)
            mangasCollection = []
        }
        Task {
            await getMangas()
        }
    }
    
    func getMangas() async {
        do {
            let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangas(page: page))
            await MainActor.run {
                self.mangas += mangs
            }
            //            Mostrar error en pantalla, ver foto
        } catch {
            print(error)
        }
    }
    
    func updateMangas(mangasNew: [Manga]) -> [Manga] {
        var mangasN = mangasNew
        for mangaCollec in mangasCollection {
            if let index = mangasN.firstIndex(where: { $0.id == mangaCollec.id }) {
                mangasN[index] = mangaCollec
            }
        }
        return mangasN
    }
    
    func isLastItem(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    func loadNextPage(manga: Manga) {
        if isLastItem(manga: manga) {
            page += 1
            switch sortType {
            case .themes:
                Task {
                    await sortedMangasByType(sortOption: sortOption)
                }
            case .genres:
                Task {
                    await sortedMangasByType(sortOption: sortOption)
                }
            case .demographics:
                Task {
                    await sortedMangasByType(sortOption: sortOption)
                }
            case .nofilter:
                Task {
                    await searchText.isEmpty ? getMangas() : searchMangas()
                }
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
                let mangs = updateMangas(mangasNew: try await mangaInteractor.searchMangas(page: page, searchString: searchText))
                await MainActor.run {
//                    if mangs.isEmpty {
//                        searchEmpty = true
//                    } else {
//                        searchEmpty = false
//                    }
                    self.mangas += mangs
                }
            } catch {
                print(error)
            }
            //            Darle una vuelta al else
        } else {
            await MainActor.run {
                mangas.removeAll()
//                searchEmpty = false
            }
            page = 1
            Task {
                await getMangas()
            }
        }
    }
    
    func sortedMangasByType(sortOption: String) async {
        do {
            if page == 1 {
                await MainActor.run {
                    mangas.removeAll()
                }
            }
            switch sortType {
            case .themes:
                //                let mangs = try await mangaInteractor.getMangasByTheme(page: page, sortOption: sortOption)
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByTheme(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case .genres:
                //                let mangs = try await mangaInteractor.getMangasByGenre(page: page, sortOption: sortOption)
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByGenre(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case .demographics:
                //                let mangs = try await mangaInteractor.getMangasByDemographic(page: page, sortOption: sortOption)
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByDemographic(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case.nofilter:
                await MainActor.run {
                    mangas.removeAll()
                }
                page = 1
                Task {
                    await getMangas()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func removeMyCollection(manga: Manga) {
        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
            mangas[index].inCollection.toggle()
            if let index = mangasCollection.firstIndex(where: { $0.id == manga.id }) {
                mangasCollection.remove(at: index)
            }
        }
    }
    
    //    func toggleSelectionVolume(manga: Manga, volume: Int){
    //        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
    //            if mangas[index].ownedVolumes.contains(volume) {
    //                mangas[index].ownedVolumes.remove(volume)
    //            } else {
    //                mangas[index].ownedVolumes.insert(volume)
    //            }
    //        }
    //    }
    
    func updateManga(manga: Manga) {
        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
            mangas[index] = manga
        }
        if let index = mangasCollection.firstIndex(where: { $0.id == manga.id }) {
            mangasCollection[index] = manga
        }
    }
    
    func addMyCollection(manga: Manga) {
        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
            mangas[index].inCollection.toggle()
            mangasCollection.append(mangas[index])
        }
    }
}
