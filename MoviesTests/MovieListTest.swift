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
    var listMoviesPresenter : ListMoviesPresenter!
    
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
    
    //MARK: Presenter Test
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
