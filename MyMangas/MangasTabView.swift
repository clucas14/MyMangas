//
//  MangasTabView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 24/12/23.
//

import SwiftUI

struct MangasTabView: View {
    
    var body: some View {
        TabView {
            MangasGridView()
                .tabItem {
//                    Label("My collection", systemImage: "books.vertical")
                    Label("My collection", systemImage: "character.book.closed.fill.ja")
                }
            MangasListView()
                .tabItem {
                    Label("Mangas", systemImage: "books.vertical")
                }
        }
    }
}

#Preview {
    MangasTabView()
        .environmentObject(MangaVM.test)
}
