//
//  MangaViewModel.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 21/12/23.
//

import Foundation

final class MangaVM: ObservableObject {
    let network: DataInteractorProtocol
    
    @Published var mangas: [Manga] = []
    
    init(network: DataInteractorProtocol = Network()) {
        self.network = network
        Task {
            await getMangas()
        }
    }
    
    func getMangas() async {
        do {
            let mangs = try await network.getMangas(page: 1, per: 10)
            await MainActor.run {
                self.mangas = mangs
            }
//            Mostrar error en pantalla
        } catch {
            print(error)
        }
    }
}
