//
//  MangaDetailView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

struct MangaDetailView2: View {
    @State var isPresentedEdit = false
    @State var manga: Manga
    
    var body: some View {
        Form {
            Section {
                VStack {
                    MangaPictureView(manga: manga, size: .detailPicture)
                        .padding(.top, 5)
                    MangaCircleScoreView(manga: manga)
                    //No lo puedo hacer con offset porque la animación se salta el offset y se va moviendo hasta el offset
                    //.offset(CGSize(width: 130, height: -395.0))
                        .padding(.top, -385)
                        .padding(.leading, 250)
                }
                DetailInformationMangaView(manga: manga)
//                SectionGenres(manga: manga)
//                SectionMyCollection(isPresentedEdit: $isPresentedEdit, manga: $manga)
                DisclosureGroup("**Genres**") {
                    if !manga.genres.isEmpty {
                        ForEach(manga.genres) {
                            Text($0.genre.rawValue)
                        }
                    } else {
                        Text("No information")
                    }
                }
                DisclosureGroup("**My Collection**") {
                    Text("Volumes: \(manga.listOwnedVolumes)")
                    Text("Reading volume: \(manga.readingVolume)")
                    Text("Complete collection: \(manga.stringCompleteCollection)")
                    Button {
                        isPresentedEdit.toggle()
                    } label: {
                        Text("Editar")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .opacity(manga.inCollection ? 1 : 0)
            }
    //        .listStyle(.sidebar)
            .navigationTitle(manga.title)
            .sheet(isPresented: $isPresentedEdit, content: {
                UpdateMangaCollection(editVM: MangaEditVM(manga: manga), manga: $manga)
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
        })
        }
    }
}

#Preview {
    NavigationStack {
        MangaDetailView2(manga: .test)
    }
}
