//
//  MVVMListMoviesViewController.swift
//  Movies
//
//  Created by Jaime Laino on 7/12/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import UIKit

class MVVMListMoviesViewController: ListMoviesTableViewController {
    fileprivate let viewModel = ListMoviesViewModel(service: MockListMoviesImpl())
    fileprivate var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
        startActivityIndicator()
        viewModel.listMovies()
    }
}

extension MVVMListMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListMoviesTableViewCell
        let cellViewModel = viewModel.movies[indexPath.row]
        
        cell.titleLabel?.text = cellViewModel.title
        cell.gendreLabel.text = cellViewModel.gendres()
        cell.releaseDateLabel.text = cellViewModel.releaseDate()
        cellViewModel.onDidLoadImage = { [weak self, weak cellViewModel, weak cell] in
            guard let index = self?.viewModel.movies.index(where: { $0.movieId == cellViewModel?.movieId }),
            index == indexPath.row
            else { return }
            
            cell?.posterImageView.image = cellViewModel?.image
        }
        cellViewModel.loadImage()
        return cell
    }
}

private extension MVVMListMoviesViewController {
    func configureBinding() {
        updateView()
        viewModel.onListDidChange = { [weak self] in
            self?.updateView()
            self?.tableView.reloadData()
        }
        viewModel.onTitleDidChange = { [weak self] in
            self?.updateView()
        }
    }
    
    func updateView() {
        stopActivityIndicator()
        self.title = viewModel.listTitle
        showErrorIfNeeded()
    }
    
    func showErrorIfNeeded() {
        guard let message = viewModel.errorMessage else {
            return
        }
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    func startActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
