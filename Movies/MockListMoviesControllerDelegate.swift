//
//  MockListMoviesControllerDelegate.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

class MockListMoviesControllerDelegate : ListMoviesControllerDelegate {
    var setTitleCalled = false
    var showErrorCalled =  false
    var updateMoviesCalled = false
    var errorMessage = ""
    
    func configureTitle() {
        setTitleCalled = true
    }
    
    func update(movies: [Movie], error: String?) {
        updateMoviesCalled = true
        
        guard let message = error else { return }
        
        errorMessage = message
        showErrorCalled = true
    }
}
