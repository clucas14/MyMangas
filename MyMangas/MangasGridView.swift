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

#Preview {
    MangasGridView()
        .environmentObject(MangaVM.test)
}
