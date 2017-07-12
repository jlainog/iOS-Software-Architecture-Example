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
    fileprivate let service : ListMovies
    
    var listType : MovieListType = .inTheathersNow {
        didSet {
            listMovies()
            delegate?.configureTitle()
        }
    }
    var delegate : ListMoviesControllerDelegate? = nil {
        didSet { delegate?.configureTitle() }
    }
    var movies = [Movie]()
    var title :String {
        switch listType {
        case .inTheathersNow:
            return "Movies in Theathers"
        case .upcoming:
            return "Upcomming Movies"
        }
    }

    init(service: ListMovies) {
        self.service = service
    }
    
    func listMovies() {
        service.listMovies(listType: listType,
                           page: 0)
        { [weak self] (movies, error) in
            self?.movies = movies
            self?.delegate?.update(movies: movies, error: error)
        }
    }
}
