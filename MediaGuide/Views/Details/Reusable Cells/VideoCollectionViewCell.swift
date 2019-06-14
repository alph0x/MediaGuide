//
//  VideoCollectionViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 11/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    var video:Video? {
        didSet {
            guard let key = video?.key else { return }
            videoPlayer.loadVideoID(key)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
