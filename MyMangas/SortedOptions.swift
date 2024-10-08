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
    
    @EnvironmentObject var vm: MangaVM
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                // Mejorarlo viendo la clase 03/04/24 20:40
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            sortType = .nofilter
                        } label: {
                            Text(SortType.nofilter.rawValue)
                            Spacer()
                            if sortType == .nofilter {
                                Image(systemName: "checkmark")
                            }
                        }
                        menuGenres()
                        menuThemes()
                        menuDemographics()
                        Button {
                            vm.isPresentedSearchAuthors = true
                            vm.isPresentedSearchableByAuthors = true
                        } label: {
                            Text(SortType.authors.rawValue)
                            Spacer()
                            if sortType == .authors {
                                Image(systemName: "checkmark")
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
    }
    
    fileprivate func menuGenres() -> Menu<Text, ForEach<[MangaGenres], MangaGenres, Button<Text>>> {
        return Menu {
            ForEach(MangaGenres.allCases) {genre in
                Button {
                    sortOption = genre.rawValue
                    sortType = .genres
                } label: {
                    Text(genre.rawValue)
                }
            }
        } label: {
            Text(SortType.genres.rawValue)
        }
    }
    
    fileprivate func menuThemes() -> Menu<Text, ForEach<[MangaThemes], MangaThemes, Button<Text>>> {
        return Menu {
            ForEach(MangaThemes.allCases) {theme in
                Button {
                    sortOption = theme.rawValue
                    sortType = .themes
                } label: {
                    Text(theme.rawValue)
                }
            }
        } label: {
            Text(SortType.themes.rawValue)
        }
    }
    
    fileprivate func menuDemographics() -> Menu<Text, ForEach<[MangaDemographics], MangaDemographics, Button<Text>>> {
        return Menu {
            ForEach(MangaDemographics.allCases) {demographic in
                Button {
                    sortOption = demographic.rawValue
                    sortType = .demographics
                } label: {
                    Text(demographic.rawValue)
                }
            }
        } label: {
            Text(SortType.demographics.rawValue)
        }
    }
}

extension View {
    func sortedButton(sortOption: Binding<String>, sortType: Binding<SortType>) -> some View {
        modifier(SortedButton(sortOption: sortOption, sortType: sortType))
    }
}
