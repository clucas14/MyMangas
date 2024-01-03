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
            .searchable(text: $vm.searchText, prompt: "Introduce tu busqueda")
            .autocorrectionDisabled()
            .sortedButton(sortOption: $vm.sortOption, sortType: $vm.sortType)
            .navigationDestination(for: Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
            //            .onSubmit(of: .search) {
            //                Task {
            //                    await vm.searchMangas()
            //                }
            //            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                    // Para evitar que se ponga a buscar antes de completar el texto de búsqueda si se escribe muy rápido
                Task {
                    try await Task.sleep(nanoseconds: 1000000000)
                    if vm.searchText == newValue {
                        await vm.searchMangas()
                    }
                }
//                    Ver la opción de hacerlo con timer scechule VER FOTO
                    
//                }
            }
            
        }
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangaVM.test)
}
