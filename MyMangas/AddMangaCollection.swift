//
//  MultiSelector.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import SwiftUI

struct AddMangaCollection: View {
    
    let manga: Manga
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: MultiSelectionView(editVM: MangaEditVM(manga: manga))) {
//                                NavigationLink(value: manga) {
                        HStack {
                            Text("Volúmenes: ")
                            Spacer()
                            Text(manga.listOwnedVolumes)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Volumen en lectura:")
//                        Picker("Composer", selection: $editVM.composer) {
//                                            ForEach(vm.composers, id: \.self) { composer in
//                                                Text(composer)
//                                            }
//                                        }
                    }
                }
                Section {
                    HStack {
                        Text("Colección completa:")
                        
                    }
                }
            }
//            .navigationDestination(for: Manga.self) { manga in
//                MultiSelectionView(editVM: MangaEditVM(manga: manga))
//            }
        }
    }
}

#Preview {
    AddMangaCollection(manga: .test)
}
