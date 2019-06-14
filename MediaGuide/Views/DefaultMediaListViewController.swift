//
//  DefaultMediaListViewController.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class DefaultMediaListViewController: UIViewController {
    
    let searchPresenter = SearchPresenter()
    let mediaPresenter = MediaDetailPresenter()
    let router = MediaDetailRouter()
    let viewModel = DefaultMediaListViewModel()
    
    var mode:MediaMode?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genre:Genre? {
        didSet {
            if mode == MediaMode.movies {
                searchPresenter.moviesGenre(with: genre!) { (list) in
                    self.media = list
                }
            }else{
                searchPresenter.tvshowsGenre(with: genre!) { (list) in
                    self.media = list
                }
            }
        }
    }
    
    var query:String? {
        didSet {
            if mode == MediaMode.movies {
                searchPresenter.moviesSearch(with: query!) { (list) in
                    self.media = list
                }
            }else{
                searchPresenter.tvshowsSearch(with: query!) { (list) in
                    self.media = list
                }
            }
        }
    }
    
    var media:[Media]? = [] {
        didSet{
            guard let collection = self.collectionView else { return }
            collection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DefaultMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DefaultMediaCollectionViewCell")
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
    }

}


extension DefaultMediaListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.instance(for: media![indexPath.row], on: collectionView, and: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let c = collectionView.cellForItem(at: indexPath) as! DefaultMediaCollectionViewCell
        self.router.push(media: c.media!, on: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 2
        return CGSize(width: cellWidth, height: cellWidth / 0.6)
    }
    
}

extension DefaultMediaListViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: "Sorry :(")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: "There are no results for \(self.title!)")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage.init(named: "notResultsIcon")
    }
    
}
