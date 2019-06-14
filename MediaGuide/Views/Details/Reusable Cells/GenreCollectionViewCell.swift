//
//  GenreCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 11/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var genre:Genre? {
        didSet {
            guard let name = genre?.name else { return }
            button.setTitle(name, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.borderColor = button.titleLabel?.textColor.cgColor
    }

}
