//
//  MangaDetailViewiPad.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 14/2/24.
//

import SwiftUI

struct MangaDetailViewiPad: View {
    @State var expandedCollection = false
    @State var isPresentedEdit = false
    
    @Environment(\.dismiss) var dismiss
    
    var manga: Manga
    
    var body: some View {
        List {
            HStack {
                VStack {
                    MangaPictureView(manga: manga, size: .detailPicture)
                        .padding(.top, 5)
                    MangaCircleScoreView(manga: manga)
                        .padding(.top, -385)
                        .padding(.leading, 250)
                    Spacer()
                }
                .padding(.top, 20)
                DetailInformationMangaView(manga: manga)
            }
            SectionGenres(manga: manga)
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
        .navigationBarTitleDisplayMode(.inline)
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
