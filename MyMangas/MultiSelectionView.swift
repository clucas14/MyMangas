//
//  MultiSelectionView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import SwiftUI

struct MultiSelectionView: View {
    @ObservedObject var editVM: MangaEditVM
    
    var body: some View {
        List {
            if let volumes = editVM.manga.volumes {
                // Tengo que poner id: \.self para que no me salga un warning
                ForEach(1..<volumes + 1, id: \.self) { volume in
                    Button(action: { editVM.toggleSelectionVolume(volume: volume) }) {
                        HStack {
                            Text("Volume \(volume)")
                            #if os(iOS)
                                .foregroundStyle(.black)
                            #endif
                            Spacer()
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                                .opacity(editVM.ownedVolumes.contains(volume) ? 1 : 0)
                        }
                    }
                }
            } else {
                Text("No volume data available.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    editVM.showSelectAll ? editVM.allSlectionVolume() : editVM.removeAllSlectionVolume()
                } label: {
                    Text(editVM.showSelectAll ? "Select all" : "Remove all")
                }
            }
        }
    }
}

#Preview {
    MultiSelectionView(editVM: MangaEditVM(manga: .test))
}
