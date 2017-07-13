//
//  MovieManagedObject.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation
import CoreData

public class MovieManagedObject : NSManagedObject, Movie {
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var releaseDate: Date
    @NSManaged public var summary: String
    @NSManaged public var urlString : String
    let gendres: [Gendre] = []
    var posterImageURL: URL {
        get { return URL(string: urlString)! }
        set { urlString = newValue.absoluteString }
    }
    
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
