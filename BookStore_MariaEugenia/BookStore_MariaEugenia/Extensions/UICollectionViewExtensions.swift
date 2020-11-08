//
//  UICollectionViewExtensions.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as? T else {
            fatalError("dequeueReusableCell failure")
        }
        return cell
    }
}
