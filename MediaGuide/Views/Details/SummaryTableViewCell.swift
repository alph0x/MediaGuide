//
//  SummaryTableViewCell.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 08/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    var viewModel:MediaDetailViewModel? {
        didSet {
            guard let summary = viewModel?.summary() else { return }
            dataSource = summary
        }
    }
    
    var media:Media!{
        didSet {
            viewModel = MediaDetailViewModel(for: media, with: tableView)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[String:String] = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SummaryTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keys = Array(dataSource.keys)
        return viewModel!.summaryDetailTableViewCell(with: keys[indexPath.row], and: dataSource[keys[indexPath.row]]!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    
}
