//
//  DefaultMediaCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import SDWebImage

class DefaultMediaCollectionViewCell: UICollectionViewCell {
    
    var viewModel:MediaDetailViewModel?
    
    @IBOutlet weak var imageView: UIImageView!
    
    var media:Media? {
        didSet {
            guard let m = media else { return }
            viewModel = MediaDetailViewModel(with: m)
            imageView.sd_setImage(with: viewModel?.posterURL(), placeholderImage: UIImage(named: "icons8-no_camera"))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
