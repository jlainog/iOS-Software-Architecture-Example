//
//  MVCListMoviesViewController.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

class MVCListMoviesViewController: ListMoviesTableViewController {
    fileprivate var movies = [Movie]()
    fileprivate var listType : MovieListType = .inTheathersNow {
        didSet {
            self.configureTitle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listMovies()
    }
}

extension MVCListMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListMoviesTableViewCell
        let movie = movies[indexPath.row]
        
        cell.titleLabel?.text = "MVC: " + movie.title
        cell.gendreLabel.text = movie.gendres.reduce("") { $0.0 + $0.1.name }
        return cell
    }
}

private extension MVCListMoviesViewController {
    func listMovies() {
        let service : ListMovies = MockListMoviesImpl()
        
        configureTitle()
        service.listMovies(listType: listType,
                           page: 0)
        { [weak self] (movies, error) in
            self?.update(movies: movies, error: error)
        }
        service.listMovies(listType: listType,
                           page: 0,
                           completionHandler: update(movies:error:))
    }
    
    func update(movies: [Movie], error: String?) {
        self.movies = movies
        
        guard let message = error else { return }
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    func configureTitle() {
        switch listType {
        case .inTheathersNow:
            title = "Movies in Theathers"
        case .upcoming:
            title = "Upcomming Movies"
        }
    }
}
