//
//  Movie.swift
//  Movies
//
//  Created by Jaime Laino on 7/1/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

protocol Movie {
    var title : String { get }
    var gendres : [Gendre] { get }
    var summary : String { get }
    var releaseDate : Date { get }
    var posterImageURL : URL { get }
}

struct MovieData : Movie {
    let title: String
    let releaseDate: Date
    let summary: String
    let gendres: [Gendre]
    let posterImageURL: URL
}
