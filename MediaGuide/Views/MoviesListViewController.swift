//
//  MoviesListViewController.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import IGListKit
import EmptyDataSet_Swift

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter:MoviesListPresenter?
    var genresPresenter = GenresPresenter()
    var searchPresenter = SearchPresenter()
    
    var router = DefaultMediaListRouter()
    
    var searchController:UISearchController?
    
    var genres:[Genre]? {
        didSet {
            let genresButton = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(self.genresButtonTapped))
            self.navigationItem.rightBarButtonItem  = genresButton
        }
    }
    
    var dataSource:[UITableViewCell] = []{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesListPresenter(with: tableView)
        prepareSearchBar()
        registerReusableCells()
        presenter!.dataSource { (cells) in
            self.dataSource = cells
        }
        genresPresenter.movieGenres { (genres) in
            self.genres = genres
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController?.isActive = false
    }
    
    @objc func genresButtonTapped() {
        router.genresList(for: genres!, with: .movies, on: self.tabBarController!)
    }
    
    func prepareSearchBar() {
        self.navigationItem.searchController = UISearchController.init(searchResultsController: nil)
        searchController = self.navigationItem.searchController
        searchController?.searchBar.tintColor = UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0)
        searchController?.searchBar.delegate = self
        searchController?.dimsBackgroundDuringPresentation = false;
        searchController?.hidesNavigationBarDuringPresentation = false;
    }
    
    func registerReusableCells() {
        self.tableView.register(UINib(nibName: "HighlightedMediaListTableViewCell", bundle: nil), forCellReuseIdentifier: "HighlightedMediaListTableViewCell")
        self.tableView.register(UINib(nibName: "DetailedMediaListTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailedMediaListTableViewCell")
        self.tableView.register(UINib(nibName: "DefaultMediaListTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultMediaListTableViewCell")
    }


}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 270
        
        if dataSource[indexPath.row] is HighlightedMediaListTableViewCell {
                height = 590
            }
            
        if dataSource[indexPath.row] is DetailedMediaListTableViewCell {
                height = 350
            }
        
        return height
    }
    
    
}

extension MoviesListViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isUserInteractionEnabled = false
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isUserInteractionEnabled = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.router.defaultMediaList(for: searchBar.text!, with: .movies, on: self)
    }
}
