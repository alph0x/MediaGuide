//
//  DetailedMediaListTableViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class DetailedMediaListTableViewCell: UITableViewCell {
    var mediaPresenter:MediaDetailPresenter?
    let viewModel = DetailedMediaListViewModel()
    let router = MediaDetailRouter()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource:[Media]? = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mediaPresenter = MediaDetailPresenter()
        self.collectionView.register(UINib(nibName: "DetailedMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"DetailedMediaCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DetailedMediaListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.instance(for: dataSource![indexPath.row], on: collectionView, and: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let c = collectionView.cellForItem(at: indexPath) as! DetailedMediaCollectionViewCell
        self.router.push(media: c.media!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.frame.size
        return CGSize(width: size.width, height: size.height)
        
    }
}
