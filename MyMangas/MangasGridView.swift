//
//  MangasGridView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 16/1/24.
//

import SwiftUI

struct MangasGridView: View {
    @EnvironmentObject var vm: MangaVM
    
    let itemAdaptative = GridItem(.adaptive(minimum: 150), alignment: .center)
    
    var body: some View {
        NavigationStack {
            if vm.mangasCollection.isEmpty {
                VStack {
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView {
                            Label("Empty collection", systemImage: "books.vertical")
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
                ScrollView {
                    LazyVGrid(columns: [itemAdaptative]) {
                        ForEach(vm.mangasCollection) { manga in
                            MangaCellGridView(manga: manga)
                        }
                    }
                    .padding()
                    .navigationDestination(for: Manga.self) { manga in
                        MangaDetailView(manga: manga)
                        
                    }
                    .navigationTitle("My collection")
                    
                    //                .toolbar {
                    //                    ToolbarItem(placement: .topBarTrailing) {
                    //                        Button {
                    //                            mangasVM.mangasViewType = .list
                    //                        } label: {
                    //                            Label("List View", systemImage: "list.bullet")
                    //                        }
                    //                    }
                    //                }
                }
            }
        }
    }
}

#Preview {
    MangasGridView()
        .environmentObject(MangaVM.test)
}
