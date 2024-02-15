//
//  SectionGenres.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 15/2/24.
//

import SwiftUI

struct SectionGenres: View {
    @State var expandedGenres = false
    @State var manga: Manga
    
    var body: some View {
        Section("Genres", isExpanded: $expandedGenres) {
            if !manga.genres.isEmpty {
                ForEach(manga.genres) {
                    Text($0.genre.rawValue)
                }
            } else {
                Text("No information")
            }
        }
    }
}

#Preview {
    SectionGenres(manga: .test)
}
