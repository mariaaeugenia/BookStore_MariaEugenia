//
//  BookDetailInteractor.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookDetailBusinessLogic {
    func loadData()
}

protocol BookDetailDataStore {
    var title: String? { get set }
    var authors: [String]? { get set }
    var description: String? { get set }
    var link: String? { get set }
}

class BookDetailInteractor: BookDetailBusinessLogic, BookDetailDataStore {
    
    var presenter: BookDetailPresentationLogic?
    var title: String?
    var authors: [String]?
    var description: String?
    var link: String?
    
    init() {}
    
    // MARK: Business logic
    func loadData() {
        let authorsStr = authors?.joined(separator: ",\n")
        let vm = BookDetail.ViewModel(title: title, author: authorsStr, description: description, link: link)
        presenter?.presentBookDetail(vm: vm)
    }
}
