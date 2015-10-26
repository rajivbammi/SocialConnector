//
//  InstagramTableViewCell.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/19/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class InstagramTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var instaImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
