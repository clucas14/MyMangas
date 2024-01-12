//
//  MangaAddCollectionView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 8/1/24.
//

import SwiftUI

struct MangaAddCollectionView: View {
    var manga: Manga
    
    var body: some View {
        HStack {
            Text(manga.title)
                .font(.title)
                .bold()
        }
        HStack {
            Text("Tomos comprados: ")
                .bold()
            
        }
        HStack {
            Text("Lectura de tomo actual: ")
                .bold()
        }
        HStack {
            Text("Colección completa: ")
                .bold()
        }
        
//        NavigationView {
//            List(1...manga.volumes, id: \.self, selection: $manga.volumes) {
//                Text($0)
//            }
//            Picker("Composer", selection: $manga.volumes) {
//                ForEach(manga.volumes, id: \.self) {
//                    Text($0)
//                }
//            }
//        }
    }
}

#Preview {
    MangaAddCollectionView(manga: .test)
}
