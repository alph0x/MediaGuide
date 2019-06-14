//
//  CreditPersonCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 08/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class CreditPersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    var person:Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
