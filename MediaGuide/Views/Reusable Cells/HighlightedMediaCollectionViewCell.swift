//
//  HighlightedMediaCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import SDWebImage

class HighlightedMediaCollectionViewCell: UICollectionViewCell {
    
    var viewModel:MediaDetailViewModel?
    
    var media:Media! {
        didSet {
            viewModel = MediaDetailViewModel(with: media)
            imageView.sd_setImage(with: viewModel!.posterURL(), placeholderImage: UIImage(named: "icons8-no_camera"))
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
