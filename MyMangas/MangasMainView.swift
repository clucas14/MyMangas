//
//  ContentView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

struct MangasMainView: View {
    @EnvironmentObject var vm: MangaVM
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.mangas) {manga in
                    Text(manga.title)
                }
            }
        }
        .padding()
    }
}

#Preview {
    MangasMainView()
        .environmentObject(MangaVM.test)
}
