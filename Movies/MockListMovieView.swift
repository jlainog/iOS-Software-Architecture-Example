//
//  MockListMovieView.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

class MockListMoviesView : ListMoviesView {
    var setTitleCalled = false
    var showErrorCalled =  false
    var updateMoviesCalled = false
    var didStartRequestCalled = false
    var didFinishRequestCalled = false
    var errorMessage = ""
    var title = ""
    
    func didSetTitle(title: String) {
        setTitleCalled = true
        self.title = title
    }
    
    func showError(message: String) {
        showErrorCalled = true
        errorMessage = message
    }
    
    func onUpdateMovies() {
        updateMoviesCalled = true
    }
    
    func didStartLoading() {
        didStartRequestCalled = true
    }
    
    func didFinishLoading() {
        didFinishRequestCalled = true
    }
}
