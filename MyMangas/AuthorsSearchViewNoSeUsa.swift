//
//  AuthorsSearch.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 2/2/24.
//

import SwiftUI

        struct AuthorsSearchView: View {
            @EnvironmentObject var vm: MangaVM
            @State var isPresented = false

            var body: some View {
                NavigationView {
                    
//                        SearchBar(text: $searchText, placeholder: "Buscar autor")
                        List {
                        ForEach(vm.filteredAuthors) { author in
                            Text(author.fullName)
                                .onTapGesture {
                                    // Aquí puedes realizar la búsqueda de mangas por este autor
                                    // Llama a la función para cargar mangas asociados a este autor
                                    // Puedes pasar el autor como parámetro a la siguiente vista
                                    vm.sortOption = author.id
                                    vm.sortType = .authors
                                    isPresented.toggle()
                                    
                                    
                                    
                                }
                                }
                        }
                        .opacity(isPresented ? 0 : 1)
                    MangasListView()
                        .opacity(isPresented ? 1 : 0)
                        
                    }
                    .searchable(text: $vm.searchTextAuthors, prompt: "Buscar autor")
                    .navigationTitle("Mangas")
                }
            }
        

    

#Preview {
    AuthorsSearchView()
}
