//
//  DetailedMediaListViewModel.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 09/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class DetailedMediaListViewModel {
    
    func instanceList(with list:[Media], on tableView:UITableView) -> DetailedMediaListTableViewCell {
        let c:DetailedMediaListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailedMediaListTableViewCell") as! DetailedMediaListTableViewCell
        c.dataSource = list
        return c
    }
    
    func instance(for media:Media, on collectionView:UICollectionView, and indexPath:IndexPath) -> DetailedMediaCollectionViewCell {
        let c:DetailedMediaCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedMediaCollectionViewCell", for: indexPath) as! DetailedMediaCollectionViewCell
        c.media = media
        return c
    }
    
}
