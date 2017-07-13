//
//  MovieData.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/25/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

extension MovieWebData: Movie {
    var id: String { return movieID.stringValue }
    var releaseDate: Date {
        //Transform releaseDateString
        return Date()
    }
    var summary: String { return overview }
    var gendres: [Gendre] { return [] }
    var posterImageURL: URL { return URL(string: posterPath)! }
}

struct MovieWebData: Parseable {
    let adult: NSNumber
    let backdropPath: String
    let budget: NSNumber
    let homepage: String
    let imdbID: String
    let movieID: NSNumber
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: NSNumber
    let posterPath: String
    let releaseDateString: String
    let revenue: NSNumber
    let runtime: NSNumber
    let status: String
    let tagline: String
    let title: String
    let video: NSNumber
    let voteAverage: NSNumber
    let voteCount: NSNumber
    
    init(json: NSDictionary) {
        self.adult = json["adult"] as? NSNumber ?? NSNumber(value: 0)
        self.backdropPath = ListMoviesWebService.imgBaseURL + (json["backdrop_path"] as? String ?? "")
        self.budget = json["budget"] as? NSNumber ?? NSNumber(value: 0)
        self.homepage = json["homepage"] as? String ?? ""
        self.imdbID = json["imdb_id"] as? String ?? ""
        self.movieID = json["id"] as? NSNumber ?? NSNumber(value: 0)
        self.originalLanguage = json["original_language"] as? String ?? ""
        self.originalTitle = json["original_title"] as? String ?? ""
        self.overview = json["overview"] as? String ?? ""
        self.popularity = json["popularity"] as? NSNumber ?? NSNumber(value: 0)
        self.posterPath = ListMoviesWebService.imgBaseURL + (json["poster_path"] as? String ?? "")
        self.releaseDateString = json["release_date"] as? String ?? ""
        self.revenue = json["revenue"] as? NSNumber ?? NSNumber(value: 0)
        self.runtime = json["runtime"] as? NSNumber ?? NSNumber(value: 0)
        self.status = json["status"] as? String ?? ""
        self.tagline = json["tagline"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.video = json["video"] as? NSNumber ?? NSNumber(value: 0)
        self.voteAverage = json["vote_average"] as? NSNumber ?? NSNumber(value: 0)
        self.voteCount = json["vote_count"] as? NSNumber ?? NSNumber(value: 0)
    }
    
}
