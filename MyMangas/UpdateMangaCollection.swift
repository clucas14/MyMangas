//
//  UpdateMangaCollection.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 27/1/24.
//

import SwiftUI

struct UpdateMangaCollection: View {
    @ObservedObject var editVM: MangaEditVM
    @EnvironmentObject private var vm: MangaVM
    @Binding var manga: Manga
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                SectionVolumes(editVM: editVM)
                SectionReadingVolume(editVM: editVM)
                SectionCollection(editVM: editVM)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let mang = editVM.validateManga() {
                            manga = mang
//                            if mang.inCollection {
                                vm.updateManga(manga: mang)
//                            } else {
//                                vm.addMyCollection(manga: mang)
//                            }
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
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
        UpdateMangaCollection(editVM: MangaEditVM(manga: .test), manga: Binding.constant(.test))
    }
}

