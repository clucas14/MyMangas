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
                    .padding(.top, -395)
                    .padding(.leading, 250)
            }
            .navigationTitle(manga.title)
        }
    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: .test)
    }
}
