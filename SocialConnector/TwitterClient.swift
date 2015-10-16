//
//  TwitterClient.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

let twitterConsumerKey = "3JJEBZUjh5polfD69sstSOHd1"
let twitterConsumerSecret = "NXM4J5Yiy8WwMyERTbiEgX6Qlx4OEqWvqitGJjqUrHa3V1IYpi"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    //var loginCompletion: ((TwitterUser: TwitterUser?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        //loginCompletion = completion
        
        // Fetch request token and redirect to autherization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo1://oauth"), scope:
            nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
                print("Got request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failure in request toke")
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "Post", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                print("==========User=======\n:\(response)")
                //let user = User(dictionary: response as! NSDictionary)
                //User.currentUser = user
                //println("user \(user.name)")
                //self.loginCompletion!(user: user, error: nil)
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error Getting current user")
                    //self.loginCompletion!(user:nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failure in getting access token")
                //self.loginCompletion!(user:nil, error: error)
        }
    }

    
}
