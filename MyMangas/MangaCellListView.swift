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
            VStack {
                MangaCircleScoreView(manga: manga, circleSize: .small, progress: true)
                ZStack {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 20, height: 23)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
//                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                    Image(systemName: "character.book.closed.fill.ja")
                        .foregroundStyle(.yellow)
                }
                .padding(.top, -20)
                .opacity(manga.inCollection ? 1 : 0)
            }
        }
    }
}

#Preview {
    MangaCellListView(manga: .test)
}
