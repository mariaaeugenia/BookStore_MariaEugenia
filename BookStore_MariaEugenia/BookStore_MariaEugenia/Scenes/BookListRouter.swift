//
//  BookListRouter.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookListRoutingLogic {
    func routeToImageDetail()
}

protocol BookListDataParsing {
    var dataStore: BookListDataStore? { get }
}

class BookListRouter: NSObject, BookListRoutingLogic {
    weak var viewController: BookListViewController?
    var dataStore: BookListDataStore?
    
    // MARK: Routing
    func routeToImageDetail() {
//        let vc = ImageDetailViewController()
//        guard let dataStore = dataStore, let destinationRouter = vc.router, var destinationDataSource = destinationRouter.dataStore else { return }
//        passDataToDetails(source: dataStore, destination: &destinationDataSource)
//        vc.modalPresentationStyle = .fullScreen
//        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
//    private func passDataToDetails(source: BookListDataStore, destination: inout ImageDetailDataStore) {
//        destination.id = source.id
//    }
}
