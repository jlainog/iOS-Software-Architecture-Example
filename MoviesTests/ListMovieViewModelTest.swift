//
//  ListMovieViewModelTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class ListMovieViewModelTest: XCTestCase {

    func testMVVMListMovieViewModel_Success() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let viewModel = ListMoviesViewModel(service: service)
        
        viewModel.listMovies()
        viewModel.onListDidChange = {
            XCTAssert(viewModel.movies.count != 0)
        }
        XCTAssertEqual(viewModel.listTitle, "Movies in Theathers")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testMVVMListMovieViewModel_Error() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: false)
        let viewModel = ListMoviesViewModel(service: service)
        
        viewModel.listMovies()
        viewModel.onListDidChange = {
            XCTAssert(viewModel.movies.count == 0)
        }
        XCTAssertEqual(viewModel.listTitle, "Movies in Theathers")
        XCTAssertEqual(viewModel.errorMessage, "Error, try again later")
    }
    
    func testMVVMListMovieViewModel_ListTypeChange() {
        let service : ListMovies = MockListMoviesImpl(testSuccess: true)
        let viewModel = ListMoviesViewModel(service: service)
        var onTitleDidChangeCalled = false
        
        viewModel.onListDidChange = {
            XCTAssert(viewModel.movies.count != 0)
        }
        viewModel.onTitleDidChange = {
            onTitleDidChangeCalled = true
        }
        
        viewModel.listType = .inTheathersNow
        XCTAssertEqual(viewModel.listTitle, "Movies in Theathers")
        
        viewModel.listType = .upcoming
        XCTAssertEqual(viewModel.listTitle, "Upcomming Movies")
        
        XCTAssertTrue(onTitleDidChangeCalled)
    }
    
    func testMVVMMovieCellViewModel() {
        let date = Date(timeIntervalSince1970: 1499895044.847753)
        let movie = MovieData(id: "0",
                              title: "cell title",
                              releaseDate: date,
                              summary: "",
                              gendres: [GendreData(id: "4", name: "Gendre")],
                              posterImageURL: URL(string: "cell.com")!)
        let viewModel = MovieCellViewModel(movie: movie)
        let waitingForService = expectation(description: "loadImage")
        
        XCTAssertEqual(viewModel.gendres(), "4: Gendre,")
        XCTAssertEqual(viewModel.releaseDate(), "Release date: 2017/07/12")
        
        XCTAssertNil(viewModel.image)
        viewModel.loadImage()
        XCTAssertEqual(viewModel.image, viewModel.placeholder)
        viewModel.onDidLoadImage = {
            waitingForService.fulfill()
            XCTAssertEqual(viewModel.image, viewModel.errorImagePlaceholder)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
