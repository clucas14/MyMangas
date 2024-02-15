//
//  DetailInformationMangaView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 15/2/24.
//

import SwiftUI

struct DetailInformationMangaView: View {
    @State var expandedSypnosis = false
    
    var manga: Manga
    
    var body: some View {
        VStack(alignment: .leading) {
            if expandedSypnosis {
                Text(manga.sypnosis ?? "")
                    .animation(.default, value: expandedSypnosis)
            } else {
                Text(manga.sypnosis ?? "")
                    .lineLimit(4)
                    .animation(.default, value: expandedSypnosis)
            }
            Button(expandedSypnosis ? "Less" : "More") {
                withAnimation {
                    expandedSypnosis.toggle()
                }
            }
            .bold()
            Divider()
            HStack {
                Text("Japanese title: ")
                    .bold()
                Spacer()
                Text(manga.titleJapanese ?? "")
            }
            Divider()
            Text("Authors: ")
                .bold()
            Text(manga.authors.isEmpty ? "No information" : manga.listAuthors)
            Divider()
            Text("Demographics: ")
                .bold()
            Text(manga.demographics.isEmpty ? "No information" : manga.listDemographics)
            Divider()
            Text("Themes: ")
                .bold()
            Text(manga.themes.isEmpty ? "No information" : manga.listThemes)
        }
    }
}

#Preview {
    DetailInformationMangaView(manga: .test)
}
