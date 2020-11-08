//
//  BookListWorker.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import PromiseKit

protocol BookListNetworkLogic {
    func getBooks(for query: String, at page: Int) -> Promise<BookList.Response>
}

class BookListWorker: BookListNetworkLogic {
    let network = NetworkProvider.shared
    func getBooks(for query: String, at page: Int) -> Promise<BookList.Response> {
        network.request(.getBooks(query: query, maxResult: 20, startIndex: page))
    }
}
