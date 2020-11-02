//
//  BookListInteractor.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookListBusinessLogic {
    func doSomething(request: BookList.Something.Request)
}

class BookListInteractor: BookListBusinessLogic {
    var presenter: BookListPresentationLogic?
    fileprivate lazy var worker = BookListWorker()
    
    // MARK: Business logic
    
    func doSomething(request: BookList.Something.Request) {
        worker.doSomeWork()
        
        let response = BookList.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
