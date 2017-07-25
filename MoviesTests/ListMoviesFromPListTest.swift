//
//  ListMoviesFromPListTest.swift
//  MoviesTests
//
//  Created by Jaime Laino on 7/25/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class ListMoviesFromPListTest: XCTestCase {

    func testListMovies() {
        let service = ListMoviesFromPList()
        let waitingForService = expectation(description: "listMoviesExpectation")
        
        service.listMovies(listType: .inTheathersNow, page: 1) { (list, errorMessage) in
            guard let message = errorMessage else {
                waitingForService.fulfill()
                return
            }
            
            XCTFail("### Fail: \(message) ###")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
