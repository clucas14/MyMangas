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
    @Published var mangasCollection: [Manga] {
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
            page = 1
            Task {
                await sortedMangasByType(sortOption: sortOption)
            }
        }
    }
    @Published var sortOption = ""
    @Published var searchEmpty = false
    
    var allAuthors : [Author] = []
    
    @Published var isPresentedSearchAuthors = false
    @Published var isPresentedAuthors = false
    @Published var isPresentedSearchableByAuthors = false
    
    @Published var filteredAuthors: [Author] = []
    
    @Published var searchTextAuthors = "" {
        didSet {
            isPresentedSearchAuthors = true
            isPresentedAuthors = true
            filteredAuthors = allAuthors.filter { $0.fullName.localizedCaseInsensitiveContains(searchTextAuthors) }
        }
        willSet {
            page = 1
        }
    }
    
    @Published var msg = ""
    @Published var showAlert = false
    
    var page = 1
    
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
            await getAuthors()
        }
    }
    
    func getAuthors() async {
        do {
            let auth = try await mangaInteractor.getAuthors()
            await MainActor.run {
                self.allAuthors = auth
            }
        } catch let error as NetworkError{
            print(error)
            msg = "\(error)"
            showAlert.toggle()
        } catch {
            print(error)
            msg = "\(error)"
            showAlert.toggle()
        }
    }
    
    func getMangas() async {
        do {
            let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangas(page: page))
            await MainActor.run {
                self.mangas += mangs
            }
        } catch let error as NetworkError{
            print(error)
            msg = "\(error)"
            showAlert.toggle()
        } catch {
            print(error)
            msg = "\(error)"
            showAlert.toggle()
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
            case .authors:
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
                    if mangs.isEmpty && page == 1 {
                        searchEmpty = true
                    } else {
                        searchEmpty = false
                    }
                    self.mangas += mangs
                }
            } catch {
                print(error)
            }
        } else {
            await MainActor.run {
                mangas.removeAll()
                searchEmpty = false
            }
            page = 1
            Task {
                await getMangas()
            }
        }
    }
    
    func searchMangasByAuthor(sortOption: String) async {
        if !searchTextAuthors.isEmpty {
            do {
                // Si es la primera búsqueda vaciamos el array de mangas
                if page == 1 {
                    await MainActor.run {
                        mangas.removeAll()
                    }
                }
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByAuthor(page: page, sortOption: sortOption))
                await MainActor.run {
                    if mangs.isEmpty && page == 1 {
                        searchEmpty = true
                    } else {
                        searchEmpty = false
                    }
                    self.mangas += mangs
                }
            } catch {
                print(error)
            }
        } else {
            await MainActor.run {
                mangas.removeAll()
                searchEmpty = false
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
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByTheme(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case .genres:
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByGenre(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case .demographics:
                let mangs = updateMangas(mangasNew: try await mangaInteractor.getMangasByDemographic(page: page, sortOption: sortOption))
                await MainActor.run {
                    self.mangas += mangs
                }
            case .authors:
                await searchMangasByAuthor(sortOption: sortOption)
            case .nofilter:
                await MainActor.run {
                    mangas.removeAll()
                    isPresentedSearchAuthors = false
                    isPresentedAuthors = false
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
            if let indexCollec = mangasCollection.firstIndex(where: { $0.id == manga.id }) {
                mangasCollection.remove(at: indexCollec)
            }
        }
    }
        
    func updateManga(manga: Manga) {
        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
            mangas[index] = manga
        }
        if let index = mangasCollection.firstIndex(where: { $0.id == manga.id }) {
            mangasCollection[index] = manga
        }
    }
        
//    Aquí sería conveniente usar inout para el manga?¿
    func addMyCollection(manga: Manga) {
        var mng = manga
        if let index = mangas.firstIndex(where: { $0.id == mng.id }) {
            mng.inCollection.toggle()
            mangas[index] = mng
            mangasCollection.append(mng)
        }
    }
}
