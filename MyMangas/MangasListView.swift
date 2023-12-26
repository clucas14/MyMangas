//
//  ContentView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var vm: MangaVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaCellView(manga: manga)
                            .onAppear {
                                vm.loadNextPage(manga: manga)
                            }
                    }
                }
            }
            .navigationTitle("Mangas")
            .navigationDestination(for: Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
            .searchable(text: $vm.searchText, prompt: "Introduce tu busqueda")
            
        }
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangaVM.test)
}
