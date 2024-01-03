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
    
    var body: some View {
        ZStack {
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
                .searchable(text: $vm.searchText, prompt: "Introduce tu busqueda")
                .autocorrectionDisabled()
                .sortedButton(sortOption: $vm.sortOption, sortType: $vm.sortType)
                .navigationDestination(for: Manga.self) { manga in
                    MangaDetailView(manga: manga)
                }
                .onChange(of: vm.searchText) { oldValue, newValue in
                    // Para evitar que se ponga a buscar antes de completar el texto de búsqueda si se escribe muy rápido
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        if vm.searchText == newValue {
                            await vm.searchMangas()
                        }
                    }
                    //                    Ver la opción de hacerlo con timer scechule VER FOTO
                }
            }
        
        HStack {
            Text("No hay resultados en la búsqueda")
        }
        .opacity(vm.searchEmpty ? 1 : 0)
        }
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangaVM.test)
}
