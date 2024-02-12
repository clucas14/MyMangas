//
//  MangaPictureView.swift
//  MyMangas Watch Watch App
//
//  Created by Carlos Lucas Sánchez on 12/2/24.
//

import SwiftUI

enum PictureSize: CGFloat {
    case cellPicture = 90
    case detailPicture = 195
}

struct MangaPictureView: View {
    let manga: Manga
    var size: PictureSize = .cellPicture
    
    var body: some View {
        AsyncImage(url: manga.urlPicture) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size.rawValue, height: size.rawValue/0.9)
                .clipShape(RoundedRectangle(cornerRadius: size == .detailPicture ? 10 : 10))
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding(.leading, -10)
        } placeholder: {
            Image(systemName: "book.pages")
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue, height: size.rawValue/0.9)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding(.leading, -10)
        }
    }
}

#Preview {
    MangaPictureView(manga: .test)
}
