//
//  UIImageView-Extension.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 15/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    func imageFromUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch image from url:", err.localizedDescription)
                return
            }
            
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
    }
}
