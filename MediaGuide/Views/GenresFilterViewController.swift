//
//  GenresFilterViewController.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

enum MediaMode {
    case movies
    case tvshows
}

class GenresFilterViewController: UIViewController {
    let presenter = SearchPresenter()
    var viewModel:MediaDetailViewModel?
    let router = DefaultMediaListRouter()
    
    @IBOutlet weak var tableView: UITableView!
    
    var mode:MediaMode?
    var genres:[Genre]? = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MediaDetailViewModel(with: tableView)
        tableView.register(UINib(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeViewController))
    }
    
    @objc func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension GenresFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel!.genreTableViewCell(for: genres![indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let genre = genres![indexPath.row]
        self.router.defaultMediaList(for: genre, with: mode!, on: self)
    }
    
}
