//
//  ContentView.swift
//  MyMangas Watch Watch App
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selectedManga: Manga?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.mangas) { manga in
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
            }
            .navigationTitle("Mangas")
            .sheet(item: $selectedManga, content: { manga in
                AddMangaCollection(editVM: MangaEditVM(manga: manga))
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
            })
            .navigationDestination(for: Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button {
//                        
//                    } label: {
//                        Text("Filters")
//                    }
//                }
//            }
        }
    }
}

#Preview {
    MangasListView()
}
