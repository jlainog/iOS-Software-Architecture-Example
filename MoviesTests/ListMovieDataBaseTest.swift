//
//  ListMovieDataBaseTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
import MagicalRecord
@testable import Movies

class ListMovieDataBaseTest: XCTestCase {
    
    let db : ListMovies = ListMovieDataBase()

    func testListMovieDataBase_Success() {
        let waitingForService = expectation(description: "listMovieDataBaseSuccessExpectation")
        
        populateDatabase() {
            self.db.listMovies(listType: .inTheathersNow,
                          page: 0)
            { movies, errorMessage in
                guard let message = errorMessage else {
                    waitingForService.fulfill()
                    XCTAssert(movies.last?.posterImageURL.absoluteString == "https://image.tmdb.org/t/p/w640/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg")
                    XCTAssert(movies.first?.title == "DB Mock Title")
                    return
                }
                
                XCTFail("### Fail: \(message) ###")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testListMovieDataBase_EmptyDB() {
        let waitingForService = expectation(description: "listMovieDataBaseEmptyDBExpectation")
        
        emptyDB()
        db.listMovies(listType: .inTheathersNow,
                      page: 0)
        { movies, errorMessage in
            guard let message = errorMessage else {
                XCTFail("### Fail ###")
                return
            }
            
            waitingForService.fulfill()
            XCTAssertEqual(message, "Sorry Empty DB")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

private extension ListMovieDataBaseTest {
    func emptyDB() {
        MagicalRecord.save(blockAndWait: { ctx in
            MovieManagedObject.mr_truncateAll(in: ctx)
        })
    }
    
    func populateDatabase(completion: @escaping () -> Void) {
        var movies = [Movie]()
        
        MagicalRecord.setupCoreDataStack()
        
        for i in 1..<10 {
            let timeInterval = TimeInterval(1499894044 + (30 * i))
            
            movies.append(mockMovie(id: "\(i)",
                releaseDate: Date(timeIntervalSince1970: timeInterval),
                imageURL: "https://image.tmdb.org/t/p/w640/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg")
            )
        }
        
        emptyDB()
        MagicalRecord.save({ (ctx) in
            for m in movies {
                let entity = MovieManagedObject.mr_createEntity(in: ctx)
                
                entity?.id = m.id
                entity?.title = m.title
                entity?.releaseDate = m.releaseDate
                entity?.summary = m.summary
                entity?.posterImageURL = m.posterImageURL
            }
        })  { (_, _) in
            completion()
        }
    }
    
    func mockMovie(id: String,
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
