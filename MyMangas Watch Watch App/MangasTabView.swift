//
//  MangasTabView.swift
//  MyMangas Watch Watch App
//
//  Created by Carlos Lucas Sánchez on 12/2/24.
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
