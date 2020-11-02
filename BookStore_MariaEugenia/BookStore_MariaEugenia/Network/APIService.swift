//
//  APIService.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

enum APIService {
    case getBooks(query: String, maxResult: Int, startIndex: Int)
}

extension APIService: Endpoint {
    var url: URL? {
        return URL(string: Constants.Network.baseURL + path)
    }
    
    var path: String {
        switch self {
        case .getBooks:
            return "books/v1/volumes"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBooks(let query, let maxResult, let startIndex):
            return [
                "q" : query,
                "maxResults" : maxResult,
                "startIndex" : startIndex
            ]
        }
    }
    
    
}
