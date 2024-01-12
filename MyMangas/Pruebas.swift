//
//  Pruebas.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 8/1/24.
//

import SwiftUI

struct Pruebas: View {
//    @State private var selectedVolumes: Set<Int> = []
//    let totalVolumes = 18 // Número total de tomos
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(1...totalVolumes, id: \.self) { volume in
//                    MultipleSelectionRow(volume: volume, isSelected: selectedVolumes.contains(volume))
//                        .onTapGesture {
//                            toggleSelection(for: volume)
//                        }
//                }
//            }
//            .navigationTitle("Selecciona los tomos")
////            .navigationBarItems(trailing: EditButton())
//        }
//    }
//
//    func toggleSelection(for volume: Int) {
//        if selectedVolumes.contains(volume) {
//            selectedVolumes.remove(volume)
//        } else {
//            selectedVolumes.insert(volume)
//        }
//    }
//}
//
//struct MultipleSelectionRow: View {
//    var volume: Int
//    var isSelected: Bool
//
//    var body: some View {
//        HStack {
//            Text("Tom \(volume)")
//            Spacer()
//            if isSelected {
//                Image(systemName: "checkmark")
//                    .foregroundColor(.blue)
//            }
//        }
//        .contentShape(Rectangle())
//    }
    @State private var selectedVolumes: Set<Int> = []
        let totalVolumes = 18 // Número total de tomos

        var body: some View {
            NavigationView {
                List(1...totalVolumes, id: \.self, selection: $selectedVolumes) { volume in
                    Text("Tom \(volume)")
                }
                .navigationBarItems(trailing: EditButton())
            }
        }
}
#Preview {
    Pruebas()
}
