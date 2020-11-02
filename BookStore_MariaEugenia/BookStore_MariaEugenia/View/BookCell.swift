//
//  BookCell.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import UIKit

class BookCell: CollectionViewCell {

    private var imageView: UIImageView!
    
    override func prepareViews() {
        imageView = .init()
    }
    
    override func addViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func configureViews() {
        imageView.contentMode = .scaleAspectFit
    }
    
}

