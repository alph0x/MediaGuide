//
//  DefaultMediaListViewModel.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 09/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class DefaultMediaListViewModel {
    
    func instanceList(with title:String, and list:[Media], on tableView:UITableView) -> DefaultMediaListTableViewCell {
        let c:DefaultMediaListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DefaultMediaListTableViewCell") as! DefaultMediaListTableViewCell
        c.dataSource = list
        c.titleLabel.text = title
        return c
    }
    
    func instance(for media:Media, on collectionView:UICollectionView, and indexPath:IndexPath) -> DefaultMediaCollectionViewCell {
        let c:DefaultMediaCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultMediaCollectionViewCell", for: indexPath) as! DefaultMediaCollectionViewCell
        c.media = media
        return c
    }
    
}
