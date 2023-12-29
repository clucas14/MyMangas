//
//  SortedOptions.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 28/12/23.
//

import SwiftUI

fileprivate struct SortedButton: ViewModifier {
    @Binding var sortOption: String
    @Binding var sortType: SortType
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Menu {
                            ForEach(MangaGenres.allCases) {genre in
                                Button {
                                    sortType = .genres
                                    sortOption = genre.rawValue
                                } label: {
                                    Text(genre.rawValue)
                                }
                            }
                        } label: {
                            Text(SortType.genres.rawValue)
                        }
                        Menu {
                            ForEach(MangaThemes.allCases) {theme in
                                Button {
                                    sortType = .themes
                                    sortOption = theme.rawValue
                                } label: {
                                    Text(theme.rawValue)
                                }
                            }
                        } label: {
                            Text(SortType.themes.rawValue)
                        }
                    } label: {
                        Text("Filtrar por")
                    }
                }
            }
    }
}

extension View {
    func sortedButton(sortOption: Binding<String>, sortType: Binding<SortType>) -> some View {
        modifier(SortedButton(sortOption: sortOption, sortType: sortType))
    }
}
