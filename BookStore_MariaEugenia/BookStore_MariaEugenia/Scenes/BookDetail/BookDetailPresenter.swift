//
//  BookDetailPresenter.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookDetailPresentationLogic {
    func presentBookDetail(vm: BookDetail.ViewModel)
}

class BookDetailPresenter: BookDetailPresentationLogic {
    weak var viewController: BookDetailDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentBookDetail(vm: BookDetail.ViewModel) {
        viewController?.displayBookDetail(viewModel: vm)
    }
}
