//
//  Endpoint.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

typealias Parameters = [String:Any]

protocol Endpoint {
    var url: URL? { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
