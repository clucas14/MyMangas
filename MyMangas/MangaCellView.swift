//
//  MangaCellView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaCellView: View {
    var manga: Manga
    
    var body: some View {
        HStack(alignment: .top) {
            MangaPictureView(manga: manga)
            VStack(alignment: .leading) {
                Text(manga.title)
                   // .font(.headline)
                Text(manga.status)
                    .font(.caption)
                    .opacity(0.6)
            }
            Spacer()
            MangaCircleScoreView(manga: manga, circleSize: .small)
        }
    }
}

#Preview {
    MangaCellView(manga: .test)
}
