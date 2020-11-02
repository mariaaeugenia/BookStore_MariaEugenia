//
//  UIImageViewExtensions.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import UIKit
import SDWebImage

extension UIImageView {
    public func setImage(url: String?, with placeholder: UIImage? = nil, _ completion: ((_ image: UIImage?) -> Void)? = nil) {
        let url: URL? = URL(string: url ?? "")
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        image = placeholder
        sd_setImage(with: url, placeholderImage: placeholder, options: [.continueInBackground, .retryFailed, .avoidAutoSetImage]) { (img, error, _, _) in
            if completion == nil {
                self.image = img ?? placeholder
            } else {
                completion?(img ?? placeholder)
            }
        }
    }
}
