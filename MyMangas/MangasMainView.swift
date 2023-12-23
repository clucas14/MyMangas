//
//  ContentView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

struct MangasMainView: View {
    @EnvironmentObject var vm: MangaVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaCellView(manga: manga)
                    }
                }
            }
            .navigationTitle("Mangas")
            //            navigationDestination(for: Manga.self) { manga in
            //
            //            }
        }
    }
}

#Preview {
    MangasMainView()
        .environmentObject(MangaVM.test)
}
