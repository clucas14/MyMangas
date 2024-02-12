//
//  MyMangas_WatchApp.swift
//  MyMangas Watch Watch App
//
//  Created by Carlos Lucas Sánchez on 11/2/24.
//

import SwiftUI

@main
struct MyMangas_Watch_Watch_AppApp: App {
    @StateObject var vm = MangaVM()
    
    var body: some Scene {
        WindowGroup {
            MangasTabView()
                .environmentObject(vm)
        }
    }
}
