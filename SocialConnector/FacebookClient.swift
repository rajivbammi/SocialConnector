//
//  FacbookClient.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/20/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

class FacebookClient: NSObject {
    var fbResults: [FacebookUser]?
    
    class var sharedInstance: FacebookClient {
        struct Static {
            static let instance =  FacebookClient()
        }
        return Static.instance
    }
}
