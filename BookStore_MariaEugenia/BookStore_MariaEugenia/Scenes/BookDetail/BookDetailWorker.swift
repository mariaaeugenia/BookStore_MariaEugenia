//
//  BookDetailWorker.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import PromiseKit
import CoreData


protocol BookDetailNetworkLogic {
    func makeFavorite(_ book: BookDetail.Request) throws -> Bool
    func removeFavorite(with id: String) throws -> Bool
}

class BookDetailWorker: BookDetailNetworkLogic {
    
    func makeFavorite(_ book: BookDetail.Request) throws -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw NetworkError.custom("Couldn't access database") }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let itemEntity = NSEntityDescription.entity(forEntityName: "Book", in: managedContext) else { throw NetworkError.custom("Couldn't access Entity") }
        let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
        item.setValue(book.id, forKey: BookEntity.id.rawValue)
        item.setValue(book.title, forKeyPath: BookEntity.title.rawValue)
        item.setValue(book.authors, forKey: BookEntity.author.rawValue)
        item.setValue(book.description, forKey: BookEntity.bookDescription.rawValue)
        item.setValue(book.thumbnail, forKey: BookEntity.thumbnail.rawValue)
        item.setValue(book.link, forKey: BookEntity.link.rawValue)
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            throw error
        }
    }
    
    func removeFavorite(with id: String) throws -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw NetworkError.custom("Couldn't access database") }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do {
            let obj = try managedContext.fetch(fetchRequest)
            
            if let objectToDelete = obj[0] as? NSManagedObject {
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    return true
                }
                catch {
                    throw error
                }
            }
            return false
        } catch {
            throw error
        }
    }
}
