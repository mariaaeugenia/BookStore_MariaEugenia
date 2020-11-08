//
//  BookListViewController.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//  Copyright (c) 2020 Maria Eugênia Pereira Teixeira. All rights reserved.
//

import UIKit
import SVProgressHUD


protocol BookListDisplayLogic: class {
    func reloadData()
    func displayError(title: String, message: String)
    func shouldDisplayLoading()
    func shouldHideLoading()
    func displayBookDetail()
}

class BookListViewController: ViewController {
    
    struct CollectionView {
        static let backgroundColor: UIColor = .white
        static let itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10,
                                             height: UIScreen.main.bounds.width/2 - 10)
        static let minimumLineSpacing: CGFloat = 10
    }
    
    private var collectionView: UICollectionView!
    private var collectionLayout: UICollectionViewFlowLayout!
    
    var interactor: BookListBusinessLogic?
    var router: (NSObjectProtocol & BookListRoutingLogic & BookListDataParsing)?
    
    //MARK: -
    //MARK: - CONFIGURE VIEW
    override func prepareViews() {
        collectionLayout = .init()
        collectionView = .init(frame: .zero, collectionViewLayout: collectionLayout)
    }
    
    override func addViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        title = "iOS Books"
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped(_ :)))
        navigationItem.rightBarButtonItem = filterButton
        configureCollectionView()
        configureScene()
    }
    
    
    // MARK: Setup
    private func configureScene() {
        let viewController = self
        let interactor = BookListInteractor()
        let presenter = BookListPresenter()
        let router = BookListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: -
    //MARK: - CONFIGURE COLLECTIONVIEW
    private func configureCollectionView() {
        collectionLayout.itemSize = CollectionView.itemSize
        collectionLayout.minimumLineSpacing = CollectionView.minimumLineSpacing
        collectionView.backgroundColor = CollectionView.backgroundColor
        collectionView.registerCell(BookCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: -
    //MARK: - BUTTON ACTION
    @objc private func filterButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
}

// MARK: Display logic
extension BookListViewController: BookListDisplayLogic {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayError(title: String, message: String) {
        presentAlert(with: title, and: message)
    }
    
    func shouldDisplayLoading() {
        SVProgressHUD.show()
    }
    
    func shouldHideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func displayBookDetail() {
        router?.routeToBookDetail()
    }
}

// MARK: -
// MARK: COLLECTIONVIEW DELEGATE & DATASOURCE
extension BookListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        interactor?.numberOfRows ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BookCell.self, indexPath: indexPath)
        if let vm = interactor?.cellForRow(at: indexPath.row) {
            cell.set(vm: vm)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        interactor?.didSelect(at: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height - CollectionView.itemSize.height {
            interactor?.performRequest(isPagging: true)
        }
    }
}
