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
    // Controllers
    var loginViewController: LoginViewController!
    var contentViewController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogin", name: userDidLoginNotification, object: nil)

        // Check if Twitter User or insta User
        // If not then show login
        //else show timeline
        if((User.sharedInstance.twitterUser) != nil) {
            print("inside if")
        } else {
            print("inside Containerview: Twitter User is null. Calling login")
            self.loginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            addViewControllers(self.loginViewController, destView: contentPanelView)
        }
        // Do any additional setup after loading the view.
    }

    func addViewControllers (viewController: UIViewController, destView: UIView) {
        self.addChildViewController(viewController)
        destView.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        viewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userLogin() {
        print("Inside Containerview: inside user did Login function")
        if (self.contentViewController == nil) {
            print("Inside Containerview: self.contentViewController == nil")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.contentViewController = storyboard.instantiateViewControllerWithIdentifier("TweetNagivationController") as! UINavigationController
            self.addChildViewController(self.contentViewController)
            print("Inside Containerview: added TweetNagivationController as child")
        }
        print("Inside Containerview:here")
        self.contentPanelView.addSubview(self.contentViewController.view)
        //self.contentViewController.view.frame = self.view.frame
        //self.contentViewController.didMoveToParentViewController(self)
    }
}
