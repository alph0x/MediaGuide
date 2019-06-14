//
//  HighlightedMediaListTableViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class HighlightedMediaListTableViewCell: UITableViewCell {
    let mediaPresenter = MediaDetailPresenter()
    let presenter = HighlightedMediaListViewModel()
    let router = MediaDetailRouter()
    
    var updateHandler:(([Media]) -> Void)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource:[Media] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "HighlightedMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HighlightedMediaCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

extension HighlightedMediaListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.instance(for: dataSource[indexPath.row], on: collectionView, and: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let c = collectionView.cellForItem(at: indexPath) as! HighlightedMediaCollectionViewCell
        self.router.push(media: c.media!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
    }
    
}
