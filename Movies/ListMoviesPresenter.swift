//
//  ListMoviesPresenter.swift
//  Movies
//
//  Created by Jaime Laino on 7/7/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

protocol ListMoviesView : class {
    func didStartLoading()
    func didFinishLoading()
    func onUpdateMovies()
    func showError(message: String)
    func didSetTitle(title: String)
}

final class ListMoviesPresenter {
    unowned fileprivate var view : ListMoviesView
    fileprivate let service : ListMovies
    var movies = [Movie]()
    var listType : MovieListType {
        didSet {
            self.listMovies()
            self.setTitle()
        }
    }
    
    init(view: ListMoviesView, service: ListMovies) {
        self.view = view
        self.service = service
        self.listType = .inTheathersNow
        self.setTitle()
    }
    
    func listMovies() {
        self.view.didStartLoading()
        service.listMovies(listType: .inTheathersNow,
                           page: 0)
        { [weak self] (list, errorMessage) in
            self?.view.didFinishLoading()
            
            guard let message = errorMessage else {
                self?.updateMovies(response: list)
                return
            }
            
            self?.view.showError(message: message)
        }
    }
}

private extension ListMoviesPresenter {
    func setTitle() {
        let title : String
        
        switch listType {
        case .inTheathersNow:
            title = "Movies in Theathers"
        case .upcoming:
            title = "Upcomming Movies"
        }
        
        self.view.didSetTitle(title: title)
    }
    
    func updateMovies(response: [Movie]) {
        movies = response
        self.view.onUpdateMovies()
    }
}
