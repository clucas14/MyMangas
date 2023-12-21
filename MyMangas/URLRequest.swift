//
//  URLRequest.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func getPaginateMangas(url: URL, page: Int = 1, per: Int = 20) -> URLRequest {
        var request = URLRequest(url: url)
        request.url?.append(queryItems: [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "per", value: "\(per)")])
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
