//
//  NetworkError.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case serverError
    case parserError
    case emptyData
    case custom(String)
    case unknown
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Malformed URL"
        case .serverError:
            return "Server failure"
        case .parserError:
            return "Parse response object failure"
        case .emptyData:
            return "Data not found"
        case .custom(let msg):
            return msg
        case .unknown:
            return "Unknown Error"
        }
    }
}
