//
//  ViewControllerConfigurating.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation

protocol ViewControllerConfigurating: class {
    func setup()
    func prepareViews()
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewControllerConfigurating {
    func setup() {
        prepareViews()
        addViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
