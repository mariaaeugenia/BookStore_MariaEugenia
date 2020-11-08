//
//  BookListInteractor.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import PromiseKit

enum ListState {
    case loading
    case normal
}

protocol BookListBusinessLogic {
    var numberOfRows: Int { get }
    func cellForRow(at index: Int) -> BookList.ViewModel?
    func didSelect(at index: Int)
    func performRequest(isPagging: Bool)
}

protocol BookListDataStore {
    var id: String? { get }
}

class BookListInteractor: BookListBusinessLogic, BookListDataStore {
   
    var id: String?
    
    var presenter: BookListPresentationLogic?
    let worker: BookListNetworkLogic
    var books: [Item]
    var nextPage: Int
    var totalItems: Int
    var listState: ListState
    
    var numberOfRows: Int {
        books.count
    }
    
    init(with worker: BookListNetworkLogic = BookListWorker()) {
        self.worker = worker
        books = []
        nextPage = 0
        totalItems = 1
        listState = .normal
    }
    
    func performRequest(isPagging: Bool) {
        guard listState != .loading, numberOfRows <= totalItems else {
            return
        }
        presenter?.shouldPresentLoading()
        listState = .loading
        worker.getBooks(for: "ios", at: nextPage).done { [weak self] response in
            let items = response.items ?? []
            if isPagging {
                self?.books.append(contentsOf: items)
            } else {
                self?.books = items
            }
            self?.nextPage += 1
            self?.totalItems = response.totalItems ?? 1
            self?.presenter?.reloadData()
        }.ensure { [weak self] in
            self?.presenter?.shouldRemoveLoading()
            self?.listState = .normal
        }.catch { [weak self] error in
            self?.presenter?.onError(title: "Error", message: error.localizedDescription)
        }
    }
    
    // MARK: Business logic
    func cellForRow(at index: Int) -> BookList.ViewModel? {
        guard index >= 0 && index < numberOfRows else { return nil }
        let url = books[index].volumeInfo?.imageLinks?.thumbnail
        return BookList.ViewModel(url: url)
    }
    
    func didSelect(at index: Int) {
        guard let idSelected = books[index].id else { return }
        id = idSelected
        presenter?.presentImageDetail()
    }
    
}
