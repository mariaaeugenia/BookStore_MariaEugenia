//
//  BookListPresenter.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookListPresentationLogic {
    func reloadData()
    func onError(title: String, message: String)
    func shouldPresentLoading()
    func shouldRemoveLoading()
    func presentImageDetail()
}

class BookListPresenter: BookListPresentationLogic {
    weak var viewController: BookListDisplayLogic?
    
    // MARK: Presentation logic
    func reloadData() {
        viewController?.reloadData()
    }
    
    func onError(title: String, message: String) {
        viewController?.displayError(title: title, message: message)
    }
    
    func shouldPresentLoading() {
        viewController?.shouldDisplayLoading()
    }
    
    func shouldRemoveLoading() {
        viewController?.shouldHideLoading()
    }
    
    func presentImageDetail() {
        viewController?.displayBookDetail()
    }
}
