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
    func saveToFavorite()
    func removeFromFavorite()
}

protocol BookDetailDataStore {
    var item: Item? { get set }
    var book: BookDetail.Request? { get set }
}

class BookDetailInteractor: BookDetailBusinessLogic, BookDetailDataStore {
    
    var presenter: BookDetailPresentationLogic?
    let worker: BookDetailNetworkLogic
    
    var item: Item?
    var book: BookDetail.Request?
    
    init(with worker: BookDetailNetworkLogic = BookDetailWorker()) {
        self.worker = worker
    }
    
    // MARK: Business logic
    func loadData() {
        if item != nil {
            let authorsStr = item?.volumeInfo?.authors?.joined(separator: ",\n")
            let vm = BookDetail.ViewModel(title: item?.volumeInfo?.title, author: authorsStr, description: item?.volumeInfo?.description, link: item?.saleInfo?.buyLink, isFavorite: false)
            presenter?.presentBookDetail(vm: vm)
        } else {
            let vm = BookDetail.ViewModel(title: book?.title, author: book?.authors, description: book?.description, link: book?.link, isFavorite: true)
            presenter?.presentBookDetail(vm: vm)
        }
    }
    
    func saveToFavorite() {
        let authorsStr = item?.volumeInfo?.authors?.joined(separator: ",\n")
        let request = BookDetail.Request(id: item?.id, title: item?.volumeInfo?.title, authors: authorsStr, description: item?.volumeInfo?.description, link: item?.saleInfo?.buyLink, thumbnail: item?.volumeInfo?.imageLinks?.thumbnail)
        do {
            let success = try worker.makeFavorite(request)
            if success {
                presenter?.onAlert(title: "Alert", message: "Successfully marked as favorite")
            }
        } catch { 
            presenter?.onAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    func removeFromFavorite() {
        guard let id = item?.id else { return }
        do {
            let success = try worker.removeFavorite(with: id)
            if success {
                presenter?.onAlert(title: "Alert", message: "Successfully removed from favorites")
            }
        } catch {
            presenter?.onAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
