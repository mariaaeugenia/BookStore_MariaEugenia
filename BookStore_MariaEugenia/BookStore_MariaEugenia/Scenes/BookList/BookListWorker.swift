//
//  BookListWorker.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import CoreData
import PromiseKit

protocol BookListNetworkLogic {
    func getBooks(for query: String, at page: Int) -> Promise<BookList.Response>
    func getFavoriteBooks() throws -> [BookDetail.Request]
}

class BookListWorker: BookListNetworkLogic {
    let network = NetworkProvider.shared
    func getBooks(for query: String, at page: Int) -> Promise<BookList.Response> {
        network.request(.getBooks(query: query, maxResult: 20, startIndex: page))
    }
    
    func getFavoriteBooks() throws -> [BookDetail.Request] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw NetworkError.custom("Couldn't access database") }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        var books: [BookDetail.Request] = []
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { throw NetworkError.custom("Couldn't access Entity") }
            for data in result  {
                if let id = data.value(forKey: BookEntity.id.rawValue) as? String, !id.isEmpty {
                    let title = data.value(forKey: BookEntity.title.rawValue) as? String
                    let author = data.value(forKey: BookEntity.author.rawValue) as? String
                    let bookDescription = data.value(forKey: BookEntity.bookDescription.rawValue) as? String
                    let link = data.value(forKey: BookEntity.link.rawValue) as? String
                    let thumbnail = data.value(forKey: BookEntity.thumbnail.rawValue) as? String
                    let book = BookDetail.Request(id: id, title: title, authors: author, description: bookDescription, link: link, thumbnail: thumbnail)
                    books.append(book)
                }
            }
            return books
        }
        catch {
            throw error
        }
    }
}
