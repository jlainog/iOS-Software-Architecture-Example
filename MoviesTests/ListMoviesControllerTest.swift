//
//  ListMoviesControllerTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class ListMoviesControllerTest: XCTestCase {
    
    func testMVCController_Success() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let mockDelegate = MockListMoviesControllerDelegate()
        let controller = ListMoviesController(service: service)
        
        controller.delegate = mockDelegate
        controller.listMovies()
        XCTAssertTrue(mockDelegate.updateMoviesCalled)
        XCTAssertTrue(mockDelegate.setTitleCalled)
        XCTAssertFalse(mockDelegate.showErrorCalled)
    }
    
    func testMVCController_Error() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: false)
        let mockDelegate = MockListMoviesControllerDelegate()
        let controller = ListMoviesController(service: service)
        
        controller.delegate = mockDelegate
        controller.listMovies()
        XCTAssertTrue(mockDelegate.updateMoviesCalled)
        XCTAssertTrue(mockDelegate.setTitleCalled)
        XCTAssertTrue(mockDelegate.showErrorCalled)
    }
    
    func testMVCController_ListTypeChange() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let mockDelegate = MockListMoviesControllerDelegate()
        let controller = ListMoviesController(service: service)
        
        controller.delegate = mockDelegate
        
        controller.listType = .inTheathersNow
        XCTAssertTrue(mockDelegate.setTitleCalled)
        XCTAssertEqual(controller.title, "Movies in Theathers")
        
        mockDelegate.setTitleCalled = false
        controller.listType = .upcoming
        XCTAssertTrue(mockDelegate.setTitleCalled)
        XCTAssertEqual(controller.title, "Upcomming Movies")
        
        XCTAssertTrue(mockDelegate.updateMoviesCalled)
    }

}
