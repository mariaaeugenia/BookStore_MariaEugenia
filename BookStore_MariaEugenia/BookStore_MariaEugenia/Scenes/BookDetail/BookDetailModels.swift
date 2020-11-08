//
//  BookDetailModels.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

enum BookEntity: String {
    case id
    case title
    case author
    case bookDescription
    case link
    case thumbnail
}

enum BookDetail {
    // MARK: Use cases
    struct Request {
        var id: String?
        var title: String?
        var authors: String?
        var description: String?
        var link: String?
        var thumbnail: String?
    }
    
    struct ViewModel {
        let title: String?
        let author: String?
        let description: String?
        let link: String?
        let isFavorite: Bool
    }
}
