//
//  BookListPresenter.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookListPresentationLogic {
    func presentSomething(response: BookList.Something.Response)
}

class BookListPresenter: BookListPresentationLogic {
    weak var viewController: BookListDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentSomething(response: BookList.Something.Response) {
        let viewModel = BookList.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
