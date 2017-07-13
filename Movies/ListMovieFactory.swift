//
//  ListMovieFactory.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

struct ListMoviesFactory {
    static func listMovies() -> ListMovies {
        return MockListMoviesImpl()
    }
}
