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
    var loginCompletion: ((user: TwitterUser?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

    func loginWithCompletion(completion: (user: TwitterUser?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to autherization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo1://oauth"), scope:
            nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
                print("Inside Twitter Client:loginWithCompletion")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failure in request token")
        }
    }
    
    func openURL(url: NSURL) {
        print("Inside Twitter Client:openURL")
        fetchAccessTokenWithPath("oauth/access_token", method: "Post", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            print("Inside TwitterClient: openURL - got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                let twitterUser = TwitterUser(dictionary: response as! NSDictionary)
                TwitterUser.currentTwitterUser = twitterUser
                self.loginCompletion?(user: twitterUser, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("Error Getting current user")
                    self.loginCompletion!(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                print("Failure in getting access token")
                //self.loginCompletion!(user: nil, error: error)
        }
    }
    
    func logout() {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    }

    
    func homeTimelineWithParams (params: NSDictionary?, completion: (tweets:[Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("Error in fetching status")
                completion(tweets: nil, error: error)
        })
        
    }
    
}
