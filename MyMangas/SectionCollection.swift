//
//  SectionReadingVolume.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct SectionCollection: View {
    @ObservedObject var editVM: MangaEditVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section {
            Picker("Complete collection:", selection: $editVM.completeCollection) {
                Text("Yes").tag(true)
                Text("No").tag(false)
            }
            .padding(EdgeInsets(top: -5,leading: 0,bottom: -5,trailing: 0))
        }
    }
}

#Preview {
    SectionCollection(editVM: MangaEditVM(manga: .test))
}
