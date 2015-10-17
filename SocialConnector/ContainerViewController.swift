//
//  ContainerViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var contentPanelView: UIView!
    @IBOutlet var buttons: [UIButton]!
    var selectedIndex: Int = -1
    
    // Controllers
    var loginViewController: LoginViewController!
    @IBAction func didPressTab(sender: AnyObject) {
        print("Inside didPressTab: \(sender.tag)")
    }
    
    var contentViewController: UINavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside container")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        contentViewController = storyboard.instantiateViewControllerWithIdentifier("TweetNagivationController") as! UINavigationController
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogin", name: userDidLoginNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogout", name: userDidLogoutNotification, object: nil)

        // Check if Twitter User or insta User
        // If not then show login
        //else show timeline
        print("Printing twitter user")
        if (TwitterUser.currentTwitterUser != nil) {
            print("inside if")
            showTabs()
            self.selectedIndex = 0
            addViewControllers(contentViewController, destView: contentPanelView)
        } else {
            print("inside Containerview: Twitter User is null. Calling login")
            hideTabs()
            self.selectedIndex = -1
            addViewControllers(self.loginViewController, destView: contentPanelView)
        }
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
        print("Inside Containerview: inside user did Login function")
        if (self.contentViewController == nil) {
            print("Inside Containerview: self.contentViewController == nil")
            self.addChildViewController(self.contentViewController)
            print("Inside Containerview: added TweetNagivationController as child")
        }
        print("Inside Containerview:here")
        self.contentPanelView.addSubview(self.contentViewController.view)
        self.contentViewController.view.frame = self.view.frame
        self.contentViewController.didMoveToParentViewController(self)
        showTabs()
    }
    
    func userLogout() {
        print("Inside ContainerviewController: userlogout", terminator: "")
        addViewControllers(self.loginViewController, destView: contentPanelView)
    }

    func hideTabs() {
        print("hidding buttons")

        for btn in buttons {
            btn.hidden = true
        }
    }
    func showTabs() {
        print("showing buttons")
        for btn in buttons {
            btn.hidden = false
        }
    }
}
