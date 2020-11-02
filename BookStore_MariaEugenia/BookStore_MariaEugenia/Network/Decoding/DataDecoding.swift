//
//  DataDecoding.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

protocol DataDecoding {
    static func decode<T>(_ object: T.Type, data: Data?) throws -> T where T : Decodable
}
