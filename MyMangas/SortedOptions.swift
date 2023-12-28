////
////  SortedOptions.swift
////  MyMangas
////
////  Created by Carlos Lucas Sánchez on 28/12/23.
////
//
//import SwiftUI
//
//fileprivate struct SortedOptions: ViewModifier {
//    @Binding var sortType: SortType
//    
//    func body(content: Content) -> some View {
//        content
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Menu {
//                        Button {
//                            sortType = .ascendent
//                        } label: {
//                            Text("Ascendent")
//                        }
//                        Button {
//                            sortType = .descendent
//                        } label: {
//                            Text("Descendent")
//                        }
//                        Button {
//                            sortType = .byID
//                        } label: {
//                            Text("By ID")
//                        }
//                    } label: {
//                        Text("Sorted by")
//                    }
//                }
//            }
//    }
//}
//
//extension View {
//    func SortedOptions(sortType: Binding<SortType>) -> some View {
//        modifier(SortedButton(sortType: sortType))
//    }
//}
