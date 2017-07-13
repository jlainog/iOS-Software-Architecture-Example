//
//  MovieListTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/7/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class MovieListTest: XCTestCase {
    
    func testListMovies() {
        let service : ListMovies = MockListMoviesImpl()
        let waitingForService = expectation(description: "listMoviesExpectation")
        
        service.listMovies(listType: .inTheathersNow, page: 1) { (list, errorMessage) in
            guard let message = errorMessage else {
                waitingForService.fulfill()
                
                XCTAssert(MockListMoviesImpl.movies.first?.id == list.first?.id)
                XCTAssert(MockListMoviesImpl.movies.first?.title == list.first?.title)
                return
            }
            
            XCTFail("### Fail: \(message) ###")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
 }
