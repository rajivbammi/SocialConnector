//
//  User.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

var _currentUser: User?
//let currentUserKey = "kCurrentUserKey"

class User: NSObject {
    var twitterUser: TwitterUser?
    var instaUser: InstagramUser?
    
    class var sharedInstance: User {
        struct Static {
            static let instance =  User()
        }
        return Static.instance
    }
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        //let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        //if data != nil {
        //let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! ///NSDictionary
        //_currentUser = User(dictionary: dictionary)
        //}
        }
        return _currentUser
        }
        set(user) {
            _currentUser = user
            /*if _currentUser != nil {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize() */
        }
    }
}
