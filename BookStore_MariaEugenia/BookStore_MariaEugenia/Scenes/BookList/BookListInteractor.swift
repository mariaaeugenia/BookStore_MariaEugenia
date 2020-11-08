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
    var isFavoriteBooks: Bool { get set }
    var numberOfRows: Int { get }
    func cellForRow(at index: Int) -> BookList.ViewModel?
    func didSelect(at index: Int)
    func performRequest(isPagging: Bool)
    func getFavoriteBooks()
}

protocol BookListDataStore {
    var item: Item? { get }
    var book: BookDetail.Request? { get }
}

class BookListInteractor: BookListBusinessLogic, BookListDataStore {
   
    var item: Item?
    var book: BookDetail.Request?
    
    var presenter: BookListPresentationLogic?
    let worker: BookListNetworkLogic
    var books: [Item]
    var favBooks: [BookDetail.Request]
    var nextPage: Int
    var totalItems: Int
    var listState: ListState
    
    var isFavoriteBooks: Bool {
        didSet {
            if isFavoriteBooks == true {
                getFavoriteBooks()
            } else {
                presenter?.reloadData()
            }
        }
    }
    
    var numberOfRows: Int {
        return isFavoriteBooks ? favBooks.count : books.count
    }
    
    init(with worker: BookListNetworkLogic = BookListWorker()) {
        self.worker = worker
        books = []
        favBooks = []
        nextPage = 0
        totalItems = 1
        listState = .normal
        isFavoriteBooks = false
    }
    
    func performRequest(isPagging: Bool) {
        guard listState != .loading, numberOfRows <= totalItems, !isFavoriteBooks else {
            return
        }
        presenter?.shouldPresentLoading()
        listState = .loading
        worker.getBooks(for: "ios", at: nextPage).done { [weak self] response in
            guard let self = self else { return }
            let items = response.items ?? []
            if isPagging {
                self.books = self.books + items
            } else {
                self.books = items
            }
            self.nextPage += 1
            self.totalItems = response.totalItems ?? 1
            self.presenter?.reloadData()
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
        if isFavoriteBooks {
            let url = favBooks[index].thumbnail
            return BookList.ViewModel(url: url)
        }
        let url = books[index].volumeInfo?.imageLinks?.thumbnail
        return BookList.ViewModel(url: url)
    }
    
    func didSelect(at index: Int) {
        if isFavoriteBooks {
            let book = favBooks[index]
            self.item = nil
            self.book = book
        } else {
            let item = books[index]
            self.book = nil
            self.item = item
        }
        presenter?.presentImageDetail()
    }
    
    func getFavoriteBooks() {
        do {
            let books = try worker.getFavoriteBooks()
            self.favBooks = books
            self.presenter?.reloadData()
        } catch {
            self.presenter?.onError(title: "Error", message: error.localizedDescription)
        }
    }
    
}
