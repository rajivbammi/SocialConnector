//
//  TwitterUser.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit
var _currentTwitterUser: TwitterUser?
let currentTwitterUserKey = "kCurrentTwitterUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


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
        print("inside TwitterUser: loginWithCompletion")
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if (user != nil) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLoginNotification, object: nil))
                print("Inside Twitter User: loginWithCompletion: login successful")
                //completion()
            } else {
                print("error logging in")
            }
        }
    }
    
    
    func logout() {
        TwitterUser.currentTwitterUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
   class var currentTwitterUser: TwitterUser? {
        get {
        if _currentTwitterUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentTwitterUserKey) as? NSData
        if data != nil {
        let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
        _currentTwitterUser = TwitterUser(dictionary: dictionary)
        }
        }
        return _currentTwitterUser
        }
        set(user) {
            _currentTwitterUser = user
            
            if _currentTwitterUser != nil {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.tDictionary!, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentTwitterUserKey)
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentTwitterUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
