//
//  TweetTableViewCell.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
