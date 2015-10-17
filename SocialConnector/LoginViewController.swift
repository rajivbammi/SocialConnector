//
//  ViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTwitterLogin(sender: AnyObject) {
        print("Inside LoginViewcontroller:onTwitterLogin")
        TwitterUser.loginWithCompletion({ () -> Void in
            // logged in
        })
    }

    
    @IBAction func onInstagramLogin(sender: AnyObject) {
        print("inside Insta Login")
    }
}

