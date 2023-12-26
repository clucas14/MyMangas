//
//  MangaDetailView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    var manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                MangaPictureView(manga: manga, size: .detailPicture)
                MangaCircleScoreView(manga: manga)
                //No lo puedo hacer con offset porque la animación se salta el offset y se va moviendo hasta el offset
                //.offset(CGSize(width: 130, height: -395.0))
                    .padding(.top, -385)
                    .padding(.leading, 250)
                HStack {
                    Text("Título en japonés: ")
                    Text(manga.titleJapanese)
                }
                VStack {
                    Text("Autores: ")
                    ForEach(manga.authors) {
                        Text($0.fullName)
                    }
                }
                HStack {
                    Text("Géneros: ")
                }
            }
            .navigationTitle(manga.title)
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Text(manga.inCollection ? "Editar o eliminar" : "Añadir")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: .test)
    }
}
