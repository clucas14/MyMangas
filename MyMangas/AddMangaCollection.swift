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
                SectionVolumes(editVM: editVM)
                SectionReadingVolume(editVM: editVM)
                SectionCollection(editVM: editVM)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let mang = editVM.validateManga() {
                            if mang.inCollection {
                                vm.updateManga(manga: mang)
                            } else {
                                vm.addMyCollection(manga: mang)
                            }
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
        AddMangaCollection(editVM: MangaEditVM(manga: .test))
    }
}
