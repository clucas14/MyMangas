//
//  MangasTabViewiPad.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct MangasTabViewiPad: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selectedManga: Manga?
    
    @State var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
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
            .navigationTitle("Composers")
            .navigationDestination(for: Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
            .navigationSplitViewColumnWidth(min: 300, ideal: 400, max: 400)
        } content: {
            Group {
                //            if let first = vm.composers.first {
                //                getComposerList(composer: first)
                //            }
            }
            .navigationSplitViewColumnWidth(min: 300, ideal: 325, max: 350)
        } detail: {
            //        if let first = vm.composers.first,
            //           let score = vm.getScoresFromComposer(composer: first).first {
            //            ScoreDetailView(score: score)
            //        }
            //        MangaDetailView()
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    MangasTabViewiPad()
}
