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
                ForEach(1..<volumes + 1) { volume in
                    Button(action: { editVM.toggleSelectionVolume(volume: volume) }) {
                        HStack {
                            Text("Volume \(volume)")
                                .foregroundStyle(.black)
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
    }
}

#Preview {
    MultiSelectionView(editVM: MangaEditVM(manga: .test))
}
