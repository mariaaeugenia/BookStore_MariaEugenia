//
//  BookDetailRouter.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookDetailDataPassing {
    var dataStore: BookDetailDataStore? { get }
}

class BookDetailRouter: NSObject, BookDetailDataPassing {
    weak var viewController: BookDetailViewController?
    var dataStore: BookDetailDataStore?
}
