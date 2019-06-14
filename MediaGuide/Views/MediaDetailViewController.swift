//
//  MediaDetailViewController.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import SDWebImage

class MediaDetailViewController: UIViewController {
    
    var viewModel = MediaDetailViewModel() {
        didSet{
            self.title = viewModel.title()
            imageView.sd_setImage(with: viewModel.backdropURL(), placeholderImage: UIImage(named: "icons8-no_camera"))
        }
    }
    var presenter:MediaDetailPresenter?{
        didSet{
            guard let details = media else { return }
            presenter?.details(for: details, with: { (details) in
                self.presenter!.dataSource(for: details, with: { (cells) in
                    self.dataSource = cells
                    self.viewModel = MediaDetailViewModel(for: details, with: self.tableView)
                })
            })
        }
    }
    
    var dataSource:[UITableViewCell] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var imageView: UIImageView! = UIImageView()
    
    var media:Media? {
        didSet {
            guard let details = media else { return }
            viewModel = MediaDetailViewModel(with: details)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MediaDetailPresenter(with: tableView)
        tableView.contentInset = UIEdgeInsets(top: 270, left: 0, bottom: 0, right: 0)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 270))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }

}

extension MediaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y:CGFloat = 270 - (scrollView.contentOffset.y + 280)
        let height = min(max(y, 0), CGFloat(UIScreen.main.bounds.size.height))
        imageView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: Int(height))
    }
}
