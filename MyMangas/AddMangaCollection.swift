//
//  MultiSelector.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 11/1/24.
//

import SwiftUI

struct AddMangaCollection: View {
    
    @ObservedObject var editVM: MangaEditVM
    @EnvironmentObject var vm: MangaVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: MultiSelectionView(editVM: editVM)) {
                        HStack {
                            Text("Volúmenes: ")
                            Spacer()
                            Text(editVM.listOwnedVolumes)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                Section {
                    Picker("Volumen en lectura:", selection: $editVM.readingVolume) {
                        ForEach(editVM.sortOwnedVolumes, id: \.self) { volume in
                            Text("\(volume)")
                        }
                    }
                    .padding(EdgeInsets(top: -5,leading: 0,bottom: -5,trailing: 0))
                }
                Section {
                    Picker("Colección completa:", selection: $editVM.completeCollection) {
                        Text("Si").tag(true)
                        Text("No").tag(false)
                    }
                    .padding(EdgeInsets(top: -5,leading: 0,bottom: -5,trailing: 0))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        //                        if let manga = editVM.saveEditManga() {
                        if let manga = editVM.validateManga() {
                            if manga.inCollection {
                                vm.updateManga(manga: manga)
                            } else {
                                vm.addMyCollection(manga: manga)
                            }
                            dismiss()
                        }
                        //                        }
                    } label: {
                        Text("Guardar")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                    
                }
            }
            .alert("Validation error",
                   isPresented: $editVM.showAlert) {
                
            } message: {
                Text(editVM.msg)
            }

        }
    }
}

#Preview {
    NavigationStack {
        AddMangaCollection(editVM: MangaEditVM(manga: .test))
    }
}
