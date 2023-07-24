//
//  UIImageView+Ext.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func load(urlString: String, placeHolder: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit, isForceContentMode: Bool = false, completion: @escaping (UIImage?) -> () = { _ in }) {
        
        let cache = ImageCache.default
        // Constrain Memory Cache to 50 MB
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 50
        // Constrain Disk Cache to 250 MB
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 250
        
        kf.setImage(with: URL(string: urlString), placeholder: placeHolder, options: [.originalCache(cache)]) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            switch result {
            case .failure:
                self.contentMode = isForceContentMode ? contentMode : .scaleAspectFit
                completion(nil)
            case .success(let response):
                self.contentMode = contentMode
                completion(response.image)
            }
        }
    }
}
