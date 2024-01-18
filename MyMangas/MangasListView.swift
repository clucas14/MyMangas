//
//  ContentView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

// Si la búsqueda no devuelve nada mostrar algo

struct MangasListView: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selectedManga: Manga?
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(vm.mangas) { manga in
                        NavigationLink(value: manga) {
                            MangaCellListView(manga: manga)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        if manga.inCollection {
                                            vm.removeMyCollection(manga: manga)
                                            //                                            Mensaje de si seguro que quiere eliminarlo
                                        } else {
                                            selectedManga = manga
                                        }
                                    } label: {
                                        Label(manga.inCollection ? "Quitar de mi colección" : "Añadir a mi colección", systemImage: manga.inCollection ? "minus" : "plus")
                                    }
                                    .tint(manga.inCollection ? .red : .yellow)
                                }
                                .onAppear {
                                    vm.loadNextPage(manga: manga)
                                }
                        }
                    }
                }
                .navigationTitle("Mangas")
                .searchable(text: $vm.searchText, prompt: "Introduce tu búsqueda")
                .autocorrectionDisabled()
                .sortedButton(sortOption: $vm.sortOption, sortType: $vm.sortType)
                .navigationDestination(for: Manga.self) { manga in
                    MangaDetailView(manga: manga)
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
            VStack {
                Text("No hay resultados en la búsqueda")
                    .bold()
                Image(systemName: "magnifyingglass")
                    .font(.title)
            }
            .opacity(vm.searchEmpty ? 1 : 0)
        }
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangaVM.test)
}
