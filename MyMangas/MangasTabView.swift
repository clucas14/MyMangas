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
            Group {
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    MangasCollectionViewiPad()
                } else {
                    MangasCollectionView()
                }
            }
                    .tabItem {
                        Label("My collection", systemImage: "character.book.closed.fill.ja")
                    }
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    MangasListViewiPad()
                } else {
                    MangasListView()
                }
            }
                    .tabItem {
                        Label("Mangas", systemImage: "books.vertical")
                    }
            }
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(.black.opacity(0.6), for: .tabBar)
        }
                .tint(.yellow)
    }
}

#Preview {
    MangasTabView()
        .environmentObject(MangaVM.test)
}
