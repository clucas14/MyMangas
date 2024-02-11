//
//  SectionReadingVolume.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct SectionReadingVolume: View {
    @ObservedObject var editVM: MangaEditVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section {
            Picker("Reading volume:", selection: $editVM.readingVolume) {
                ForEach(editVM.sortOwnedVolumes, id: \.self) { volume in
                    Text("\(volume)")
                }
            }
            .padding(EdgeInsets(top: -5,leading: 0,bottom: -5,trailing: 0))
        }
    }
}

#Preview {
    SectionReadingVolume(editVM: MangaEditVM(manga: .test))
}
