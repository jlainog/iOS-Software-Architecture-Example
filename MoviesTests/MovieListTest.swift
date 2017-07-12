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
    
    //MARK: ViewModel Test
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
    
    //MARK: Controller Test
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
