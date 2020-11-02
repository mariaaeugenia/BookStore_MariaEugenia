//
//  JSONDataDecoder.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

public struct JSONDataDecoder: DataDecoding {
    static func decode<T>(_ object: T.Type, data: Data?) throws -> T where T : Decodable {
        guard let data = data, !data.isEmpty else {
            throw NetworkError.emptyData
        }
        do {
            let objectDecoded = try JSONDecoder().decode(object, from: data)
            return objectDecoded
        } catch {
             throw NetworkError.parserError
        }
    }
}
