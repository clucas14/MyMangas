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
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            sortType = .nofilter
                        } label: {
                            Text(SortType.nofilter.rawValue)
                        }
                        Menu {
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
                        Menu {
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
                        Menu {
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
                        Button {
                            vm.isPresentedSearchAuthors = true
                            vm.isPresentedSearchableByAuthors = true
                        } label: {
                            Text(SortType.authors.rawValue)
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.black)
                                .clipShape(Circle())
                                .opacity(0.6)
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundStyle(.yellow)
                        }
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
