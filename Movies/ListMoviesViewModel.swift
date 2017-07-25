//
//  ListMoviesViewModel.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

final class ListMoviesViewModel {
    fileprivate let service : ListMovies
    
    var movies = [MovieCellViewModel]()
    var listTitle : String {
        switch listType {
        case .inTheathersNow:
            return "Movies in Theathers"
        case .upcoming:
            return "Upcomming Movies"
        }
    }
    var listType : MovieListType {
        didSet { onTitleDidChange?() }
    }
    var errorMessage: String? = nil
    var onListDidChange: (() -> Void)? = nil
    var onTitleDidChange: (() -> Void)? = nil
    
    init(service: ListMovies) {
        self.service = service
        self.listType = .upcoming
    }
    
    func listMovies() {
        self.errorMessage = nil
        service.listMovies(listType: listType,
                           page: 0)
        { [weak self] (list, errorMessage) in
            guard let message = errorMessage else {
                self?.movies = list.map(MovieCellViewModel.init)
                self?.onListDidChange?()
                return
            }
            
           self?.errorMessage = message
        }
    }
}
