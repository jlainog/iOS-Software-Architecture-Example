//
//  MVCListMoviesViewController.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

class MVCListMoviesViewController: ListMoviesTableViewController {
    fileprivate let controller = ListMoviesController(service: MockListMoviesImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        controller.listMovies()
    }
}

extension MVCListMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListMoviesTableViewCell
        let movie = controller.movies[indexPath.row]
        
        cell.titleLabel?.text = "MVC: " + movie.title
        cell.gendreLabel.text = movie.gendres.reduce("") { $0.0 + $0.1.name }
        return cell
    }
}

extension MVCListMoviesViewController : ListMoviesControllerDelegate {
    func update(movies: [Movie], error: String?) {
        tableView.reloadData()
        
        guard let message = error else { return }
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    func configureTitle() {
        title = controller.title
    }
}
