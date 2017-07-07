//
//  MVPListMoviesViewController.swift
//  Movies
//
//  Created by Jaime Laino on 7/7/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

class MVPListMoviesViewController: ListMoviesTableViewController {
    fileprivate var presenter : ListMoviesPresenter!
    fileprivate var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ListMoviesPresenter(view: self as ListMoviesView,
                                        service: MockListMoviesImpl())
        presenter.listMovies()
    }
}

extension MVPListMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListMoviesTableViewCell
        let movie = presenter.movies[indexPath.row]
        
        cell.titleLabel?.text = movie.title
        cell.gendreLabel.text = movie.gendres.reduce("") { $0.0 + $0.1.name }
        return cell
    }
}

extension MVPListMoviesViewController : ListMoviesView {
    func didSetTitle(title: String) {
        self.title = title
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    func onUpdateMovies() {
        tableView.reloadData()
    }
    
    func didStartLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
