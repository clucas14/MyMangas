//
//  MangasCollectionViewiPad.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 14/2/24.
//

import SwiftUI

struct MangasCollectionViewiPad: View {
    @EnvironmentObject var vm: MangaVM
    
    @State var selected: Manga.ID?
    
    var body: some View {
        NavigationSplitView {
            if vm.mangasCollection.isEmpty {
                VStack {
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView {
                            Label("Empty collection", systemImage: "character.book.closed.fill.ja")
                        } description: {
                            Text("You do not have any manga in your collection.")
                        }
                    } else {
                        Image(systemName: "books.vertical")
                            .font(.largeTitle)
                        Text("Empty collection")
                            .font(.title)
                        Text("You do not have any manga in your collection.")
                            .font(.caption)
                    }
                }
                .navigationTitle("My collection")
            } else {
                List(vm.mangasCollection) { manga in
                    NavigationLink(value: manga) {
                        MangaCellListView(manga: manga)
                    }
                }
                .navigationDestination(for: Manga.self) { manga in
                    MangaDetailViewiPad(manga: manga)
                    
                }
                .navigationSplitViewColumnWidth(350)
                .navigationTitle("My collection")
            }
        } detail: {
            if let first = vm.mangasCollection.first {
                MangaDetailViewiPad(manga: first)
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    MangasCollectionViewiPad()
        .environmentObject(MangaVM.test)
}
