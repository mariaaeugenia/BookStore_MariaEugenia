//
//  BookDetailViewController.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 07/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit

protocol BookDetailDisplayLogic: class {
    func displayBookDetail(viewModel: BookDetail.ViewModel)
}

class BookDetailViewController: ViewController {
    
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var descriptionTextView: UITextView!
    private var linkTextView: UITextView!
    
    var interactor: BookDetailBusinessLogic?
    var router: (NSObjectProtocol & BookDetailDataPassing)?
    

    // MARK: Setup
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadData()
    }
    
    override func prepareViews() {
        stackView = .init()
        titleLabel = .init()
        authorLabel = .init()
        descriptionTextView = .init()
        linkTextView = .init()
    }
    
    override func addViewHierarchy() {
        stackView.addArrangedSubviews([
            titleLabel,
            authorLabel,
            descriptionTextView,
            linkTextView
        ])
        
        view.addSubview(stackView)
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.right.left.equalToSuperview().inset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(25)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        linkTextView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        configureStackView()
        configureLabelsAndTextView()
        configureScene()
    }
    
    private func configureScene() {
        let viewController = self
        let interactor = BookDetailInteractor()
        let presenter = BookDetailPresenter()
        let router = BookDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
    }
    
    private func configureLabelsAndTextView() {
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        authorLabel.font = .preferredFont(forTextStyle: .headline)
        authorLabel.textAlignment = .center
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 0
        
        descriptionTextView.font = .preferredFont(forTextStyle: .caption2)
        descriptionTextView.textColor = .black
        descriptionTextView.isEditable = false
        
        linkTextView.font = .preferredFont(forTextStyle: .caption2)
        linkTextView.textAlignment = .center
        linkTextView.dataDetectorTypes = .link
        linkTextView.isEditable = false
    }
}

extension BookDetailViewController: BookDetailDisplayLogic {
    func displayBookDetail(viewModel: BookDetail.ViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        descriptionTextView.text = viewModel.description
        linkTextView.text = viewModel.link
    }

}
