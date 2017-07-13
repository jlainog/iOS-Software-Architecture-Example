//
//  ListMoviePresenterTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class ListMoviePresenterTest: XCTestCase {

    func testMVPListMoviePresenter_Success() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let mockView = MockListMoviesView()
        let presenter = ListMoviesPresenter(view: mockView, service: service)
        
        presenter.listMovies()
        XCTAssertTrue(mockView.didStartRequestCalled)
        XCTAssertTrue(mockView.didFinishRequestCalled)
        XCTAssertTrue(mockView.updateMoviesCalled)
        XCTAssertTrue(mockView.setTitleCalled)
        XCTAssertFalse(mockView.showErrorCalled)
    }
    
    func testMVPListMoviePresenter_Error() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: false)
        let mockView = MockListMoviesView()
        let presenter = ListMoviesPresenter(view: mockView, service: service)
        
        presenter.listMovies()
        XCTAssertTrue(mockView.didStartRequestCalled)
        XCTAssertTrue(mockView.didFinishRequestCalled)
        XCTAssertFalse(mockView.updateMoviesCalled)
        XCTAssertTrue(mockView.setTitleCalled)
        XCTAssertTrue(mockView.showErrorCalled)
    }
    
    func testMVPListMoviePresenter_ListTypeChange() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let mockView = MockListMoviesView()
        let presenter = ListMoviesPresenter(view: mockView, service: service)
        
        presenter.listType = .inTheathersNow
        XCTAssertTrue(mockView.setTitleCalled)
        XCTAssertEqual(mockView.title, "Movies in Theathers")
        
        presenter.listType = .upcoming
        XCTAssertTrue(mockView.setTitleCalled)
        XCTAssertEqual(mockView.title, "Upcomming Movies")
        
        XCTAssertTrue(mockView.didStartRequestCalled)
        XCTAssertTrue(mockView.didFinishRequestCalled)
        XCTAssertTrue(mockView.updateMoviesCalled)
    }
    
}
