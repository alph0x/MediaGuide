//
//  HighlightedMediaListViewModel.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 09/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class HighlightedMediaListViewModel {
    
    func instanceList(with list:[Media], on tableView:UITableView) -> HighlightedMediaListTableViewCell {
        let c:HighlightedMediaListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HighlightedMediaListTableViewCell") as! HighlightedMediaListTableViewCell
        c.dataSource = list
        return c
    }
    
    func instance(for media:Media, on collectionView:UICollectionView, and indexPath:IndexPath) -> HighlightedMediaCollectionViewCell {
        let c:HighlightedMediaCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightedMediaCollectionViewCell", for: indexPath) as! HighlightedMediaCollectionViewCell
        c.media = media
        return c
    }
    
}
