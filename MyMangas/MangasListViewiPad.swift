//
//  MangasTabViewiPad.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct MangasListViewiPad: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selectedManga: Manga?
    
    var body: some View {
        NavigationSplitView {
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
                MangaDetailViewiPad(manga: manga)
            }
            .navigationSplitViewColumnWidth(350)
            .sheet(item: $selectedManga, content: { manga in
                NavigationStack {
                    AddMangaCollection(editVM: MangaEditVM(manga: manga))
                        .presentationDetents([.medium])
                        .interactiveDismissDisabled()
                }
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
            EmptySearchView()
        } detail: {
            if let first = vm.mangas.first {
                MangaDetailViewiPad(manga: first)
            }
        }
    }
}

#Preview {
    MangasListViewiPad()
        .environmentObject(MangaVM.test)
}
