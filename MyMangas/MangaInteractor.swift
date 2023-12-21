//
//  MangaInteractor.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

protocol MangaInteractorProtocol {
    func getMangas(page: Int, per: Int) async throws -> 
}
