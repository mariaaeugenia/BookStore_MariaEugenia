//
//  BookListModels.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

enum BookList {
    // MARK: Use cases
    
    struct Response: Decodable {
        let kind: String?
        let totalItems: Int?
        let items: [Item]?
    }
    struct ViewModel {
        var url: String?
    }
}

// MARK: - Item
struct Item: Decodable {
    let id: String?
    let volumeInfo: VolumeInfo?
}

// MARK: - Decodable
struct VolumeInfo: Decodable {
    let imageLinks: ImageLinks?
}

// MARK: - Decodable
struct ImageLinks: Decodable {
    let thumbnail: String?
}

