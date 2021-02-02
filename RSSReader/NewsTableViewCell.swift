//
//  NewsTableViewCell.swift
//  Lab_2
//
//  Created by Владислав Якубец on 29.11.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pudDateLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
