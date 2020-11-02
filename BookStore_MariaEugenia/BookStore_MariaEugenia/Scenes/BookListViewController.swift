//
//  BookListViewController.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookListDisplayLogic: class {
    func displaySomething(viewModel: BookList.Something.ViewModel)
}

class BookListViewController: ViewController {
    var interactor: BookListBusinessLogic?
    var router: BookListRoutingLogic?
    

    override func configureViews() {
        setupScene()
    }
    
    
    // MARK: Setup
    private func setupScene() {
        let viewController = self
        let interactor = BookListInteractor()
        let presenter = BookListPresenter()
        let router = BookListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
}

// MARK: Display logic
extension BookListViewController: BookListDisplayLogic {
    func displaySomething(viewModel: BookList.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
