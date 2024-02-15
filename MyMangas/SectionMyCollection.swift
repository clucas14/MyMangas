//
//  SectionMyCollection.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 15/2/24.
//

import SwiftUI

struct SectionMyCollection: View {
    @State var expandedCollection = false
    @Binding var isPresentedEdit: Bool
    
    @Binding var manga: Manga
    
    var body: some View {
        Section("My Collection", isExpanded: $expandedCollection) {
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
}

#Preview {
    SectionMyCollection(isPresentedEdit: .constant(false), manga: .constant(.test))
}
