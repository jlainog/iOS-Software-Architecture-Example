//
//  ListMoviesFromPList.swift
//  Movies
//
//  Created by Jaime Laino on 7/25/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

class ListMoviesFromPList : ListMovies {
    fileprivate var upcommings : [Movie] = []
    fileprivate var inTheathers : [Movie] = []
    
    init() {
        loadUpcommings()
        loadInTheathers()
    }
    
    func listMovies(listType: MovieListType, page: Int, completionHandler: @escaping ([Movie], String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            switch listType {
            case .inTheathersNow:
                completionHandler(self.inTheathers, nil)
            case .upcoming:
                completionHandler(self.upcommings, nil)
            }
        }
    }
}

private extension ListMoviesFromPList {
    func loadUpcommings() {
        guard let path = Bundle.main.path(forResource: "UpcomingMovies", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            return assertionFailure("This Should not fail")
        }
        
        self.upcommings.append(contentsOf: parsePlist(dic: dict))
    }
    
    func loadInTheathers() {
        guard let path = Bundle.main.path(forResource: "InTheathers", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
                return assertionFailure("This Should not fail")
        }
        
        self.inTheathers.append(contentsOf: parsePlist(dic: dict))
    }
    
    func parsePlist(dic: [String: AnyObject]) -> [Movie] {
        let moviesFromDic = dic["movies"] as! Array<[String: AnyObject]>
        
        return moviesFromDic.map {
            let gendres : [Gendre] = ($0["gendres"] as! Array<[String: String]>)
                .map { GendreData(id: $0["id"]!, name: $0["name"]!) }
            let date =  $0["date"] as! Date
            
            return MovieData(id: $0["id"] as! String,
                             title: $0["title"] as! String,
                             releaseDate: date,
                             summary: $0["summary"] as! String,
                             gendres: gendres,
                             posterImageURL: URL(string: $0["posterImageURL"] as! String)!)
        }
    }
}
