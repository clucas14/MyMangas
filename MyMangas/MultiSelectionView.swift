//
//  MultiSelectionView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import SwiftUI

struct MultiSelectionView: View {
    //    struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    //        let options: [Selectable]
    //        let optionToString: (Selectable) -> String
    //        @Binding
    //        var selected: Set<Selectable>
    
//    let manga: Manga
    @ObservedObject var editVM: MangaEditVM
    
    var body: some View {
        List {
            if let volumes = editVM.manga.volumes {
                ForEach(1..<volumes + 1) { volume in
                    Button(action: { editVM.toggleSelectionVolume(volume: volume) }) {
                        HStack {
                            //                            Text(optionToString(selectable)).foregroundColor(.black)
                            Text("Volumen \(volume)")
                            Spacer()
                            if editVM.manga.ownedVolumes.contains(volume) {
                                Image(systemName: "checkmark").foregroundColor(.accentColor)
                            }
                        }
                    }//.tag(selectable.id)
                }
            } else {
                Text("No hay datos de los volúmenes")
            }
        }.listStyle(GroupedListStyle())
    }
}

#Preview {
    MultiSelectionView(editVM: MangaEditVM(manga: .test))
}
