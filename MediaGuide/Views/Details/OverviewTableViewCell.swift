//
//  OverviewTableViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 08/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    var viewModel:MediaDetailViewModel?{
        didSet {
            overviewLabel.text = viewModel?.overview()
            guard let list = viewModel?.genres() else { return }
            dataSource = list
            guard let b = websiteButton else { return }
            viewModel?.website(button: b)
        }
    }
    
    var media:Media? {
        didSet {
            guard let m = media else { return }
            viewModel = MediaDetailViewModel(for: m, with: collectionView)
        }
    }
    
    var dataSource:[Genre] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension OverviewTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel!.genreCollectionViewCell(for: dataSource[indexPath.row], and: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width(for: dataSource[indexPath.row].name) + 48, height: 30)
    }
    
    func width(for text: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }
    
}
