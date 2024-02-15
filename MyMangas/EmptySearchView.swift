//
//  EmptySearchView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 15/2/24.
//

import SwiftUI

struct EmptySearchView: View {
    @EnvironmentObject var vm: MangaVM
    
    var body: some View {
        Group {
            if !vm.searchTextAuthors.isEmpty && vm.isPresentedAuthors {
                List {
                    ForEach(vm.filteredAuthors) { author in
                        Button {
                            vm.sortOption = author.id
                            vm.sortType = .authors
                            vm.isPresentedAuthors = false
                        } label: {
                            Text(author.fullName)
                        }
                        .tint(.black)
                    }
                }
                .padding(.top , 50)
            }
            if vm.searchEmpty {
                if #available(iOS 17.0, *) {
                    ContentUnavailableView.search
                } else {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                        Text("No Results")
                            .font(.title)
                            .bold()
                        Text("Check the spelling or try a new search.")
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    EmptySearchView()
}
