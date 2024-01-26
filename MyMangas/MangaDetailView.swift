//
//  MangaDetailView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    
//    @State var expandedAuthors = false
    @State var expandedGenres = false
//    @State var expandedDemographics = false
//    @State var expandedThemes = false
    @State var expandedCollection = false
    
    @State var isPresentedEdit = false
    
    @State var expandedSypnosis = false
    
    var manga: Manga
    
    var body: some View {
        //                ScrollView {
        List {
            VStack {
                MangaPictureView(manga: manga, size: .detailPicture)
                    .padding(.top, 5)
                MangaCircleScoreView(manga: manga)
                //No lo puedo hacer con offset porque la animación se salta el offset y se va moviendo hasta el offset
                //.offset(CGSize(width: 130, height: -395.0))
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
//                HStack(alignment: .top) {
                    Text("Authors: ")
                    .bold()
//                    Spacer()
                    Text(manga.authors.isEmpty ? "No information" : manga.listAuthors)
//                }
//                .opacity(manga.authors.isEmpty ? 0 : 1)
                Divider()
//                HStack(alignment: .top) {
                    Text("Demographics: ")
                    .bold()
//                    Spacer()
                    Text(manga.demographics.isEmpty ? "No information" : manga.listDemographics)
//                }
//                .opacity(manga.demographics.isEmpty ? 0 : 1)
                Divider()
//                HStack(alignment: .top) {
                    Text("Themes: ")
                    .bold()
//                    Spacer()
                Text(manga.themes.isEmpty ? "No information" : manga.listThemes)
//                }
//                .opacity(manga.themes.isEmpty ? 0 : 1)
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
                Button{
                    isPresentedEdit.toggle()
                }
            label: {
                Text("Editar")
            }
            .buttonStyle(.bordered)
            }
            .opacity(manga.inCollection ? 1 : 0)
        }
        .listStyle(.sidebar)
        .navigationTitle(manga.title)
        .sheet(isPresented: $isPresentedEdit, content: {
            AddMangaCollection(editVM: MangaEditVM(manga: manga))
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        })
    }
    
    //    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: .test)
    }
}
