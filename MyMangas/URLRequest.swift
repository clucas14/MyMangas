//
//  URLRequest.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

extension URLRequest {
    static func get(url: URL, page: Int, per: Int = 10, string: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        if let string {
            request.url?.append(path: string)
        }
        let paramPage = URLQueryItem(name: "page", value: "\(page)")
        let paramPer = URLQueryItem(name: "per", value: "\(per)")
        request.url?.append(queryItems: [paramPage, paramPer])
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        return request
    }
    
    static func getAuthors(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        return request
    }
}
