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
    //    @EnvironmentObject var vm: MangaVM
    @ObservedObject var editVM: MangaEditVM
    
    var body: some View {
        List {
            if let volumes = editVM.manga.volumes {
                ForEach(1..<volumes + 1) { volume in
                    //                    Button(action: { vm.toggleSelectionVolume(manga: manga, volume: volume) }) {
                    Button(action: { editVM.toggleSelectionVolume(volume: volume) }) {
                        HStack {
                            Text("Volumen \(volume)")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                                .opacity(editVM.ownedVolumes.contains(volume) ? 1 : 0)
                        }
                    }
                }
            } else {
                Text("No hay datos de los volúmenes")
            }
        }//.listStyle(GroupedListStyle())
    }
}

#Preview {
    MultiSelectionView(editVM: MangaEditVM(manga: .test))
}
