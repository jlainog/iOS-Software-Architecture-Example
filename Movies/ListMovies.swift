//
//  ListMovies.swift
//  Movies
//
//  Created by Jaime Laino on 7/1/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

enum MovieListType {
    case inTheathersNow
    case upcoming
}

typealias MovieListHandler = (_ movies: [Movie], _ errorMessage: String?) -> Void

protocol ListMovies {
    func listMovies(listType: MovieListType,
                    page: Int,
                    completionHandler: MovieListHandler)
}
