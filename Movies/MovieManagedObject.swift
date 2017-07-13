//
//  MovieManagedObject.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation
import CoreData

class MovieManagedObject : NSManagedObject, Movie {
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var releaseDate: Date
    @NSManaged var summary: String
    let gendres: [Gendre] = []
    @NSManaged var posterImageURL: URL
    
    convenience init(id: String,
                     title: String,
                     releaseDate: Date,
                     sumary: String,
                     posterImageURL: URL) {
        self.init()
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.summary = sumary
        self.posterImageURL = posterImageURL
    }
}
