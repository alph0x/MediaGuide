//
//  GenreTableViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    var genre:Genre? {
        didSet {
            self.textLabel?.text = genre?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
