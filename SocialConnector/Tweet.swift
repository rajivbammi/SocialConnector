//
//  Tweet.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: TwitterUser?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorite_count: String?
    var retweet_count: String?
    
    init(dictionary: NSDictionary) {
        user = TwitterUser(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["createdAt"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString ?? "")
        
        favorite_count = dictionary["favorite_count"] as? String
        retweet_count = dictionary["retweet_count"] as? String
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }

}
