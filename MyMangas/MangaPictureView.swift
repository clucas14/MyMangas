//
//  MangaPictureView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

enum PictureSize: CGFloat {
    case cellPicture = 60
    case detailPicture = 250
}

struct MangaPictureView: View {
    let manga: Manga
    var size: PictureSize = .cellPicture
    
    var body: some View {
        AsyncImage(url: manga.urlPicture) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            Image(systemName: "book.pages")
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue)
        }
    }
}

#Preview {
    MangaPictureView(manga: .test)
}
