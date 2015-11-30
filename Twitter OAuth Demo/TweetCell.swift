//
//  TweetCell.swift
//  Twitter OAuth Demo
//
//  Created by Le Thanh Tan on 11/30/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var relation: UILabel!
    
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
