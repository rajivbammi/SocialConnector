//
//  InstagramUser.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class InstagramUser: NSObject {
    var username: String?
    var userImgUrl: String?
    var imgUrl: String?
    var captionText: String?
    var likesCount: String?
    var timestamp: String?
    var commentCount: String?

    
    init(dictionary: NSDictionary) {
        let caption = dictionary["caption"]! as AnyObject
        captionText = caption["text"] as? String
        
        let fromUser = caption["from"] as? NSDictionary
        if (fromUser != nil) {
          username = fromUser?["username"] as? String
          userImgUrl = fromUser?["profile_picture"] as? String
        }
        
        let images = dictionary["images"]! as AnyObject
        let thumbnail = images["thumbnail"] as? NSDictionary
        
        if(thumbnail != nil) {
          imgUrl = thumbnail?["url"] as? String
        }
        
        let likes = dictionary["likes"]! as AnyObject
        likesCount = likes["count"] as? String
        
        timestamp = dictionary["created_time"] as? String
        
       // var comments = dictionary["comments"]! as AnyObject
        commentCount = likes["count"] as? String
    }
    
    class func instaWithArray(array: [NSDictionary]) -> [InstagramUser] {
        var instagramUser = [InstagramUser]()
        for dictionary in array {
            instagramUser.append(InstagramUser(dictionary: dictionary))
        }
        return instagramUser
    }

}
