//
//  InstagramClient.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/18/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import Foundation

var INSTAGRAM_CLIENT_ID = "367bb259c6de4d8a8ae9910d1290325f"
var instaURL = "https://api.instagram.com/v1/media/popular?client_id=" + INSTAGRAM_CLIENT_ID;
let receivedInstagramData = "receivedInstagramData"

class InstagramClient {
    var instaResults: [InstagramUser]?
    
    class var sharedInstance: InstagramClient {
        struct Static {
            static let instance =  InstagramClient()
        }
        return Static.instance
    }

    func fetchStories(resourceUrl: String) -> () {
        let manager = AFHTTPRequestOperationManager()
        manager.GET(resourceUrl, parameters: nil, success: { (operation ,responseObject) -> Void in
            print("success!!")
            if let results = responseObject["data"] as? NSArray {
               self.instaResults = InstagramUser.instaWithArray(results as! [NSDictionary])
            }
            }, failure: { (operation, requestError) -> Void in
        }
    )
  }
}