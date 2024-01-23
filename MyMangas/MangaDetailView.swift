//
//  MangaDetailView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    
    @State var expandedAuthors = false
    @State var expandedGenres = false
    @State var expandedDemographics = false
    @State var expandedThemes = false
    
    var manga: Manga
    
    var body: some View {
//                ScrollView {
                    List {
                        VStack(alignment: .center) {
                            MangaPictureView(manga: manga, size: .detailPicture)
                            MangaCircleScoreView(manga: manga)
                            //No lo puedo hacer con offset porque la animación se salta el offset y se va moviendo hasta el offset
                            //.offset(CGSize(width: 130, height: -395.0))
                                .padding(.top, -385)
                                .padding(.leading, 250)
                            HStack {
                                Text("Título en japonés: ")
                                Text(manga.titleJapanese ?? "")
                            }
                        }
//            List {
                Section("Authors: ", isExpanded: $expandedAuthors) {
                    if !manga.authors.isEmpty {
                        ForEach(manga.authors) {
                            Text($0.fullName)
                        }
                    } else {
                        Text("No information")
                    }
                }
                Section("Genres: ", isExpanded: $expandedGenres) {
                    if !manga.genres.isEmpty {
                        ForEach(manga.genres) {
                            Text($0.genre.rawValue)
                        }
                    } else {
                        Text("No information")
                    }
                }
                Section("Demographics: ", isExpanded: $expandedDemographics) {
                    if !manga.demographics.isEmpty {
                        ForEach(manga.demographics) {
                            Text($0.demographic.rawValue)
                        }
                    } else {
                        Text("No information")
                    }
                }
                Section("Themes: ", isExpanded: $expandedThemes) {
                    if !manga.themes.isEmpty {
                        ForEach(manga.themes) {
                            Text($0.theme.rawValue)
                        }
                    } else {
                        Text("No information")
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle(manga.title)
        }
        
//    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: .test)
    }
}
