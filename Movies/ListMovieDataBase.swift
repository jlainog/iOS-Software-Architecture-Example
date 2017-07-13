//
//  ListMovieDataBase.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

class ListMovieDataBase : ListMovies {
    
    static func preloadDatabase() {
        var movies = [Movie]()
        
        MagicalRecord.setupCoreDataStack()
        
        for i in 0..<10 {
            let timeInterval = TimeInterval(1499894044 + (30 * i))
            
            movies.append(mockMovie(id: "\(i)",
                          releaseDate: Date(timeIntervalSince1970: timeInterval),
                          imageURL: "https://image.tmdb.org/t/p/w640/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg")
            )
        }
        
        MagicalRecord.save({ (ctx) in
            for m in movies {
                let entity = MovieManagedObject.mr_createEntity(in: ctx)
                
                entity?.id = m.id
                entity?.title = m.title
                entity?.releaseDate = m.releaseDate
                entity?.summary = m.summary
                entity?.posterImageURL = m.posterImageURL
            }
        })
    }
    
    init() {
        MagicalRecord.setupCoreDataStack()
    }
    
    func listMovies(listType: MovieListType,
                    page: Int,
                    completionHandler: @ escaping ([Movie], String?) -> Void) {
        guard let moviesFromDB = MovieManagedObject.mr_findAll() else {
            completionHandler([], "something went wrong")
            return
        }
        
        if moviesFromDB.count == 0 {
            completionHandler([], "Sorry Empty DB")
        } else {
            completionHandler(moviesFromDB as! [Movie], nil)
        }
    }
}

private extension ListMovieDataBase {
    static func mockMovie(id: String,
                          releaseDate: Date,
                          imageURL: String) -> Movie {
        return MovieData(id: id,
                         title: "DB Mock Title",
                         releaseDate: releaseDate,
                         summary: "some sumary",
                         gendres: [],
                         posterImageURL: URL(string: imageURL)!)
    }
}
