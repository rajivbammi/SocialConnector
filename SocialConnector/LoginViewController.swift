//
//  ViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBAction func onFBViewPostClick(sender: AnyObject) {
        print("inside post")
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.center = self.view.center
        print("inside LoginViewController:FBSDKAccessToken.currentAccessToken")
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: receivedFacebookData, object: nil))

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        InstagramClient.sharedInstance.fetchStories(instaURL)
        print("fetching instagram stories")
       
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("inside Login = FBSDKAccessToken.currentAccessToken() ")
            print("inside LoginViewController:FBSDKAccessToken.currentAccessToken")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: receivedFacebookData, object: nil))
        }
        else
        {
            print("inside LoginViewController:ELSE part FBSDKAccessToken.currentAccessToken")
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "user_friends", "email"]
            loginView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTwitterLogin(sender: AnyObject) {
        print("Inside LoginViewcontroller:onTwitterLogin")
        TwitterUser.loginWithCompletion({ () -> Void in
            // logged in
        })
    }

    
    @IBAction func onInstagramLogin(sender: AnyObject) {
        print("inside Insta Login")
        if (InstagramClient.sharedInstance.instaResults != nil)
         {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: receivedInstagramData, object: nil))
        } else {
            print("no Instagram items")
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("inside loginButton")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        print("inside login: returnUserData")
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/posts",  parameters:nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            print("here.....")
            if ((error) != nil)
            {
                // Process error
                print("Error1: \(error)")
            }
            else
            {
                FacebookClient.sharedInstance.fbResults =
                FacebookUser.fbWithArray(result as! NSDictionary)
            }
        })
        
    }

}

