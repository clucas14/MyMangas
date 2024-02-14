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
            MangasCollectionView()
                .tabItem {
                    Label("My collection", systemImage: "character.book.closed.fill.ja")
                }
            MangasListView()
                .tabItem {
                    Label("Mangas", systemImage: "books.vertical")
                }
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    MangasTabView()
        .environmentObject(MangaVM.test)
}
