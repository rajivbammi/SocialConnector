//
//  TwitterUser.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit
let userDidLoginNotification = "userDidLoginNotification"

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
                User.sharedInstance.twitterUser = user
                print("Inside Twitter User: loginWithCompletion: login successful")
                //completion()
            } else {
                print("error logging in")
            }
        }
    }
    
    
    func logout() {
        //User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        User.sharedInstance.twitterUser = nil
        //NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    /*class var currentUser: User? {
        get {
        if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
        let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
        _currentUser = User(dictionary: dictionary)
        }
        }
        return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }*/
}
