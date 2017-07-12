//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

fileprivate extension UIImage {
    convenience init?(_ color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

final class MovieCellViewModel {
    fileprivate var imageURL : URL? = nil
    fileprivate lazy var placeholder: UIImage? = UIImage(UIColor.blue)
    fileprivate lazy var errorImagePlaceholder: UIImage? = UIImage(UIColor.red)
    fileprivate let movieGendres : [Gendre]
    fileprivate let date : Date
    
    let movieId : String
    let title : String
    var image : UIImage? = nil
    var onDidLoadImage: (() -> Void)? = nil
    
    init(movie: Movie) {
        movieId = movie.id
        title = movie.title
        imageURL = movie.posterImageURL
        movieGendres = movie.gendres
        date = movie.releaseDate
    }
    
    func loadImage() {
        image = placeholder
        self.onDidLoadImage?()
        
        guard let url = imageURL else { return }
        
        URLSession.shared.dataTask(with: url) {
            [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async() { () -> Void in
                    self?.image = self?.errorImagePlaceholder
                    self?.onDidLoadImage?()
                }
                return
            }
            
            DispatchQueue.main.async() { () -> Void in
                self?.image = UIImage(data: data)
                self?.onDidLoadImage?()
            }
            }.resume()
    }
    
    func releaseDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY/MM/dd"
        return "Release date: " + dateFormatter.string(from: date)
    }
    
    func gendres() -> String {
        return movieGendres.reduce("") { (string, gendre) in
            return string + gendre.id + ": " + gendre.name + ","
        }
    }
}
