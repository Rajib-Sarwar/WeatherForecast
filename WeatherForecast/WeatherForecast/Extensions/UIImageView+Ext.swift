//
//  UIImageView.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import UIKit

extension UIImageView {
    func load(from urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              guard let imageData = data else { return }
              DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
              }
            }.resume()
        }
    }
}
