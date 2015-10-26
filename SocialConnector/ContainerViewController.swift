//
//  ContainerViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit


class ContainerViewController: UIViewController {

    @IBOutlet weak var contentPanelView: UIView!
    @IBOutlet var buttons: [UIButton]!
    var selectedIndex: Int = 1
    
    // Controllers
    var loginViewController: LoginViewController!
    var contentViewController: UINavigationController!
    var instagramViewController: UIViewController!
    var facebookViewController: UINavigationController!
    
    
    @IBAction func didPressTab(sender: AnyObject) {
        print("Inside didPressTab: \(sender.tag)")
        print("previous index \(selectedIndex)")
        let previousIndex = selectedIndex
        selectedIndex  = sender.tag
        showTabs()
        print("up \(selectedIndex)")
        if (selectedIndex != previousIndex) {
            print("here \(selectedIndex)")
            switch(selectedIndex) {
            case 1:
                print("one")
                userLogin()
            case 2:
                print("two")
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: receivedInstagramData, object: nil))
            case 3:
                print("load Facebook")
                returnUserData()
            default:
                print("do nothing")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(InstagramClient.sharedInstance.instaResults == nil) {
          InstagramClient.sharedInstance.fetchStories(instaURL)
        }
        print("inside container")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        contentViewController = storyboard.instantiateViewControllerWithIdentifier("TweetNagivationController") as! UINavigationController
        instagramViewController = storyboard.instantiateViewControllerWithIdentifier("InstagramViewController") as! InstagramViewController
        facebookViewController = storyboard.instantiateViewControllerWithIdentifier("FacebookViewController") as! UINavigationController
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogin", name: userDidLoginNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogout", name: userDidLogoutNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "instagramReceived", name: receivedInstagramData, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "facebookReceived", name: receivedFacebookData, object: nil)
        
        
        // Check if Twitter User or insta User
        // If not then show login
        // else show timeline
        if (TwitterUser.currentTwitterUser != nil) {
            selectedIndex  = 1
            showTabs()
             addViewControllers(contentViewController, destView: contentPanelView)
        } else {
            hideTabs()
            if (FacebookClient.sharedInstance.fbResults != nil)
            {
                print("FB is not null")
                facebookReceived()
            } else {
                print("FB is also null:")
                print(FacebookClient.sharedInstance.fbResults)
                addViewControllers(self.loginViewController, destView: contentPanelView)
            }
            
        }
        //
    }

    func addViewControllers (viewController: UIViewController, destView: UIView) {
        self.addChildViewController(viewController)
        destView.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        viewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func userLogin() {
        if (TwitterUser.currentTwitterUser == nil) {
            hideTabs()
            addViewControllers(self.loginViewController, destView: contentPanelView)
        return
        }
        if (self.contentViewController == nil) {
            self.addChildViewController(self.contentViewController)
        }
        self.contentPanelView.addSubview(self.contentViewController.view)
        self.contentViewController.view.frame = self.view.frame
        self.contentViewController.didMoveToParentViewController(self)
        buttons[1].titleLabel?.textColor = UIColor.blackColor()
        showTabs()
    }
    
    func userLogout() {
        print("Inside ContainerviewController: userlogout", terminator: "")
        hideTabs()
        addViewControllers(self.loginViewController, destView: contentPanelView)
    }

    func hideTabs() {
        for btn in buttons {
            btn.hidden = true
        }
    }
    func showTabs() {
        for btn in buttons {
            btn.hidden = false
            if(btn.tag == selectedIndex) {
                btn.titleLabel?.textColor = UIColor.blueColor()
            } else {
                btn.titleLabel?.textColor = UIColor.blackColor()
            }
        }
    }
    func instagramReceived() {
        print("Inside Containerview: inside instagramReceived")
        print("Inside Containerview: inside user did Login function")
        if (self.contentViewController == nil) {
            print("Inside Containerview: self.contentViewController == nil")
            self.addChildViewController(self.instagramViewController)
            print("Inside Containerview: added instagramViewController as child")
        }

        self.contentPanelView.addSubview(self.instagramViewController.view)
        self.contentViewController.view.frame = self.view.frame
        self.contentViewController.didMoveToParentViewController(self)
        showTabs()
    }
    
    func facebookReceived() {
        returnUserData()
    }
    
    func returnUserData()
    {
        let params = ["fields": "message"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/posts",  parameters:params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
            FacebookClient.sharedInstance.fbResults =
                    FacebookUser.fbWithArray(result as! NSDictionary)
            self.addChildViewController(self.facebookViewController)
            
            self.contentPanelView.addSubview(self.facebookViewController.view)
            self.contentViewController.view.frame = self.view.frame
            self.contentViewController.didMoveToParentViewController(self)
            self.showTabs()
            }
        })
        
    }

}
