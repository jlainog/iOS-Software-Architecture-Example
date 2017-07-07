//
//  MockListMovies.swift
//  Movies
//
//  Created by Jaime Laino on 7/7/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

struct MockListMoviesImpl : ListMovies {
    
    static let movies : [Movie] = {
        var list = [Movie]()
        
        for i in 0..<10 {
            let gendre = GendreData(id: "\(i)",
                name: "Mock \(i)")
            let movie = MovieData(id: "\(i)",
                title: "Mock Title \(i)",
                releaseDate: Date(),
                summary: "Mock Summary \(1)",
                gendres: [gendre],
                posterImageURL: URL(string: "mockURL\(i).com")!)
            
            list.append(movie)
        }
        
        return list
    }()
    
    func listMovies(listType: MovieListType,
                    page: Int,
                    completionHandler: MovieListHandler) {
        let totalPage = 2
        
        if page > totalPage {
            completionHandler([Movie](), "You Reach final page")
            return
        }
        
        completionHandler(MockListMoviesImpl.movies, nil)
    }
}
