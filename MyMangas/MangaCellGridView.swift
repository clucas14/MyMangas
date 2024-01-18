//
//  MangasGridView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 16/1/24.
//

import SwiftUI

struct MangaCellGridView: View {
    @EnvironmentObject var vm: MangaVM
    let manga: Manga
    
    var body: some View {
        NavigationLink(value: manga) {
            VStack(alignment: .leading) {
                
                AsyncImage(url: manga.urlPicture) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding()
                } placeholder: {
                    Image(systemName: "book.pages")
                    .resizable()
                    .scaledToFill()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(manga.title)
                            .font(.headline)
                            .lineLimit(2)
//                        Text(manga.status.capitalizedValue)
//                            .font(.caption)
//                            .padding(.top, -20)
                    }
                    .foregroundColor(Color.white)
                    Spacer()
                    Button {
                        vm.removeMyCollection(manga: manga)
                    } label: {
                        Image(systemName: manga.inCollection ? "character.book.closed.fill.ja" : "character.book.closed.ja")
                    }
                    .tint(.yellow)
                    .padding(.trailing, 15)
                }
                .padding(.leading, 16)
                .padding(.top, -20)
            }
            .background {
                Rectangle()
                    .fill(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                    .padding(10)
                    .padding(.bottom, -10)
            }
        }
        .buttonStyle(.plain)
    }
    }
//}

#Preview {
    MangaCellGridView(manga: .test)
}
