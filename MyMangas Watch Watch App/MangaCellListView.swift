//
//  MangaCellListView.swift
//  MyMangas Watch Watch App
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct MangaCellListView: View {
    var manga: Manga
    
    var body: some View {
        HStack(alignment: .top) {
            MangaPictureView(manga: manga)
            VStack(alignment: .leading) {
                Text(manga.title)
                    .lineLimit(2)
                Text(manga.status.capitalizedValue)
                    .lineLimit(2)
                    .font(.caption)
                    .opacity(0.6)
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 20, height: 23)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    Image(systemName: "character.book.closed.fill.ja")
                        .foregroundStyle(.yellow)
                }
                .opacity(manga.inCollection ? 1 : 0)
            }
        }
    }
}

#Preview {
    MangaCellListView(manga: .test)
}
