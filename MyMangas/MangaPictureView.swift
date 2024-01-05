//
//  MangaPictureView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

enum PictureSize: CGFloat {
    case cellPicture = 90
    case detailPicture = 350
}

struct MangaPictureView: View {
    let manga: Manga
    var size: PictureSize = .cellPicture
    
    var body: some View {
        AsyncImage(url: manga.urlPicture) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size.rawValue/1.5, height: size.rawValue)
                .clipShape(RoundedRectangle(cornerRadius: size == .detailPicture ? 20 : 10))                
        } placeholder: {
            Image(systemName: "book.pages")
                .resizable()
                .scaledToFit()
                .frame(width: size.rawValue/1.5, height: size.rawValue)
        }
    }
}

#Preview {
    MangaPictureView(manga: .test)
}
