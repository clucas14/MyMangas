//
//  URL.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!

extension URL {
    static let getMangas = mainURL.appending(path: "list/mangas")
}
