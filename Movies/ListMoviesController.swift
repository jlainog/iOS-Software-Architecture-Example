//
//  ListMoviesController.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

protocol ListMoviesControllerDelegate {
    func update(movies: [Movie], error: String?)
    func configureTitle()
}

final class ListMoviesController {
    var delegate : ListMoviesControllerDelegate? = nil
    var movies = [Movie]()
    var title :String {
        switch listType {
        case .inTheathersNow:
            return "Movies in Theathers"
        case .upcoming:
            return "Upcomming Movies"
        }
    }
    fileprivate var listType : MovieListType = .inTheathersNow {
        didSet {
            listMovies()
            delegate?.configureTitle()
        }
    }
    
    func listMovies() {
        let service : ListMovies = MockListMoviesImpl()
        
        service.listMovies(listType: listType,
                           page: 0)
        { [weak self] (movies, error) in
            self?.movies = movies
            self?.delegate?.update(movies: movies, error: error)
        }
    }
}
