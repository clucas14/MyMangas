//
//  Form.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

struct SectionVolumes: View {
    @ObservedObject var editVM: MangaEditVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section {
            NavigationLink(destination: MultiSelectionView(editVM: editVM)) {
                HStack {
                    Text("Volumes: ")
                    Spacer()
                    Text(editVM.listOwnedVolumes)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

#Preview {
    SectionVolumes(editVM: MangaEditVM(manga: .test))
}




