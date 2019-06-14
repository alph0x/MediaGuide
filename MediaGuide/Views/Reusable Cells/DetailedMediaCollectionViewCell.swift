//
//  DetailedMediaCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class DetailedMediaCollectionViewCell: UICollectionViewCell {
    
    var viewModel:MediaDetailViewModel?
    
    @IBOutlet weak var blurredImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var media:Media! {
        didSet {
            viewModel = MediaDetailViewModel(with: media)
            blurredImageView.sd_setImage(with: viewModel!.backdropURL(), placeholderImage: UIImage(named: "icons8-no_camera"))
            imageView.sd_setImage(with: viewModel!.posterURL(), placeholderImage: UIImage(named: "icons8-no_camera"))
            titleLabel.text = viewModel!.title()
            descriptionLabel.text = viewModel!.overview()
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
