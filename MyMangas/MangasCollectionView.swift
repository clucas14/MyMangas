//
//  MangasCollectionView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 24/12/23.
//

import SwiftUI

struct MangasCollectionView: View {
    @EnvironmentObject var vm: MangaVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.myCollection) { manga in
                    NavigationLink(value: manga) {
                        MangaCellView(manga: manga)
                    }
                }
            }
            .navigationTitle("Mi colección")
            .navigationDestination(for: Manga.self) { manga in
                MangaDetailView(manga: manga)
            }
        }
    }
}

#Preview {
    MangasCollectionView()
        .environmentObject(MangaVM.test)
}
