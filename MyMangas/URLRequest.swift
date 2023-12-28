//
//  URLRequest.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

extension URLRequest {
//    static func getPaginateMangas(url: URL, page: Int, per: Int = 10) -> URLRequest {
//        var request = URLRequest(url: url)
//        let paramPage = URLQueryItem(name: "page", value: "\(page)")
//        let paramPer = URLQueryItem(name: "per", value: "\(per)")
//        request.url?.append(queryItems: [paramPage, paramPer])
//        request.timeoutInterval = 60
//        request.httpMethod = "GET"
////        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        return request
//    }
//    
//    static func searchMangas(url: URL, searchString: String, page: Int) -> URLRequest {
//        var request = URLRequest(url: url.appending(path: searchString))
//        let paramPage = URLQueryItem(name: "page", value: "\(page)")
//        request.url?.append(queryItems: [paramPage])
//        request.timeoutInterval = 60
//        request.httpMethod = "GET"
//        return request
//    }
    
    static func get(url: URL, page: Int, per: Int = 10, searchString: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        if let searchString {
            request.url?.append(path: searchString)
        }
        let paramPage = URLQueryItem(name: "page", value: "\(page)")
        let paramPer = URLQueryItem(name: "per", value: "\(per)")
        request.url?.append(queryItems: [paramPage, paramPer])
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        return request
    }
}
