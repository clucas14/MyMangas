//
//  MyMangasApp.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import SwiftUI

@main
struct MyMangasApp: App {
    @StateObject var vm = MangaVM()
    
    var body: some Scene {
        WindowGroup {
            MangasTabView()
                .environmentObject(vm)
        }
    }
}
