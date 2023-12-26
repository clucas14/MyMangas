//
//  URLRequest.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

extension URLRequest {
//    static func get(url: URL) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.timeoutInterval = 60
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        return request
//    }
    
    static func getPaginateMangas(url: URL, page: Int, per: Int = 40) -> URLRequest {
        var request = URLRequest(url: url)
        let paramPage = URLQueryItem(name: "page", value: "\(page)")
        let paramPer = URLQueryItem(name: "per", value: "\(per)")
        request.url?.append(queryItems: [paramPage, paramPer])
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
