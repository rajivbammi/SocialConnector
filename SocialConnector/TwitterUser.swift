//
//  TwitterUser.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class TwitterUser: NSObject {
    var tName: String?
    var tScreenname: String?
    var tProfileImageUrl: String?
    var tTagLine: String?
    var tDictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.tDictionary = dictionary
        tName = dictionary["name"] as? String
        tScreenname = dictionary["screen_name"] as? String
        tProfileImageUrl = dictionary["profile_image_url"] as? String
        tTagLine = dictionary["description"] as? String
    }
    
    
    class func loginWithCompletion(completion: () -> Void) {
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if (user != nil) {
                completion()
                print("Login successful")
            } else {
                print("error logging in")
            }
        }
    }

 
}
