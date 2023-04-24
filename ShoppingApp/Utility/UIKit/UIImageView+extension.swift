//
//  UIImageView+extension.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadImage(_ urlString: String, placeHolder: UIImage? = StyleConstants.Image.placeHolder) {        
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = placeHolder

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
