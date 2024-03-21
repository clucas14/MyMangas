//
//  ContentView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selectedManga: Manga?
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(vm.mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaCellListView(manga: manga)
                            .swipeActions(edge: .leading) {
                                Button {
                                    if manga.inCollection {
                                        vm.removeMyCollection(manga: manga)
                                    } else {
                                        selectedManga = manga
                                    }
                                } label: {
                                    Label(manga.inCollection ? "Remove from my collection" : "Add to my collection", systemImage: manga.inCollection ? "minus" : "plus")
                                }
                                .tint(manga.inCollection ? .red : .yellow)
                            }
                            .onAppear {
                                vm.loadNextPage(manga: manga)
                            }
                    }
                }
                .navigationTitle("Mangas")
                .searchable(text: vm.isPresentedSearchAuthors ? $vm.searchTextAuthors : $vm.searchText, isPresented: $vm.isPresentedSearchableByAuthors, prompt: vm.isPresentedSearchAuthors ? "Search by author" : "Search by title")
                .autocorrectionDisabled()
                .sortedButton(sortOption: $vm.sortOption, sortType: $vm.sortType)
                .navigationDestination(for: Manga.self) { manga in
                    MangaDetailView2(manga: manga)
                }
                .sheet(item: $selectedManga, content: { manga in
                    AddMangaCollection(editVM: MangaEditVM(manga: manga))
                        .presentationDetents([.medium])
                        .interactiveDismissDisabled()
                })
                .onChange(of: vm.searchText) { _, newValue in
                    // Para evitar que se ponga a buscar antes de completar el texto de búsqueda si se escribe muy rápido
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        if vm.searchText == newValue {
                            await vm.searchMangas()
                        }
                    }
                }
            }
            EmptySearchView()
        }
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangaVM.test)
}
