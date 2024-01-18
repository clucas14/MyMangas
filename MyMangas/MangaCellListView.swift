//
//  MangaCellView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaCellListView: View {
    var manga: Manga
    
    var body: some View {
        HStack(alignment: .top) {
            MangaPictureView(manga: manga)
            VStack(alignment: .leading) {
                Text(manga.title)
                   // .font(.headline)
                Text(manga.status.capitalizedValue)
                    .font(.caption)
                    .opacity(0.6)
                
            }
            Spacer()
            Image(systemName: "character.book.closed.fill.ja")
                .opacity(manga.inCollection ? 1 : 0)
            MangaCircleScoreView(manga: manga, circleSize: .small, progress: true)
        }
    }
}

#Preview {
    MangaCellListView(manga: .test)
}
