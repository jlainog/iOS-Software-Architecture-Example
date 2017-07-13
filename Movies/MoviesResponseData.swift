//
//  MoviesResponseData.swift
//  Movies
//
//  Created by Jaime Laino on 7/7/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

protocol MovieResponseData : Parseable {
    var page : Int { get }
    var results : [MovieWebData] { get }
    var totalResults : Int { get }
    var totalPages : Int { get }
}

struct MovieResponse : MovieResponseData {
    let page : Int
    let results : [MovieWebData]
    let totalResults : Int
    let totalPages : Int
    
    init(json: NSDictionary) {
        self.page = json["page"] as? Int ?? 0
        self.totalResults = json["total_results"] as? Int ?? 0
        self.totalPages = json["total_pages"] as? Int ?? 0
        
        guard let moviesJson = json["results"] as? [NSDictionary] else {
            self.results = []
            return
        }
        
        self.results = moviesJson.enumerated().map { offset, element in MovieWebData(json: element) }
    }
    
    init(page: Int,
         results: [MovieWebData],
         totalResults: Int,
         totalPages: Int) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
}
