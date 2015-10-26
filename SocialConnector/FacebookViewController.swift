//
//  FacebookViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/20/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class FacebookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var fbResults: [FacebookUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        fbResults  = FacebookClient.sharedInstance.fbResults
        print("fb results")
        print("fbResults count \(fbResults?.count)")
    
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fbResults != nil {
            print(fbResults?.count)
            return (fbResults?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FacebookTableViewCell", forIndexPath: indexPath) as! FacebookTableViewCell
        let result = fbResults?[indexPath.row]
        if (result?.message != nil) {
            cell.fbMessageLabel.text = "@rajivb:" + (result?.message)!
        } else {
            cell.fbMessageLabel.text = "@rajivb:" + "My FB tweet"
        }
    return cell
    }
    
}
