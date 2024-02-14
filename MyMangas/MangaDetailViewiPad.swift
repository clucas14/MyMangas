//
//  MangaDetailViewiPad.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 14/2/24.
//

import SwiftUI

struct MangaDetailViewiPad: View {
    @State var expandedGenres = false
    @State var expandedCollection = false
    @State var expandedSypnosis = false
    @State var isPresentedEdit = false
    
    @Environment(\.dismiss) var dismiss
    
    var manga: Manga
    
    var body: some View {
        List {
            VStack {
                MangaPictureView(manga: manga, size: .detailPicture)
                    .padding(.top, 5)
                MangaCircleScoreView(manga: manga)
                    .padding(.top, -385)
                    .padding(.leading, 250)
            }
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
            Section("Genres", isExpanded: $expandedGenres) {
                if !manga.genres.isEmpty {
                    ForEach(manga.genres) {
                        Text($0.genre.rawValue)
                    }
                } else {
                    Text("No information")
                }
            }
            Section("My Collection", isExpanded: $expandedCollection) {
                Text("Volumes: \(manga.listOwnedVolumes)")
                Text("Reading volume: \(manga.readingVolume)")
                Text("Complete collection: \(manga.stringCompleteCollection)")
                Button {
                    isPresentedEdit.toggle  ()
                } label: {
                    Text("Editar")
                }
                .buttonStyle(.borderedProminent)
            }
            .opacity(manga.inCollection ? 1 : 0)
        }
        .listStyle(.sidebar)
        .navigationTitle(manga.title)
        .fullScreenCover(isPresented: $isPresentedEdit) {
            dismiss()
        } content: {
            NavigationStack {
                AddMangaCollection(editVM: MangaEditVM(manga: manga))
            }
        }
    }
}

#Preview {
    MangaDetailViewiPad(manga: .test)
}
