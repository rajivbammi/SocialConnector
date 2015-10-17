//
//  TweetsViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tweets:[Tweet]?

    @IBAction func onSignOut(sender: AnyObject) {
        print("inside TweetsViewController: onsignout")
        TwitterUser.currentTwitterUser?.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside Tweets View controller: view did load")
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet =  self.tweets![indexPath.row]
        
        cell.tweetTextLabel!.text = tweet.text
        cell.nameLabel.text =
            tweet.user?.tName
        cell.accountLabel.text = tweet.user?.tScreenname
        
        let url = NSURL(string: tweet.user?.tProfileImageUrl as String!)
        cell.tweetImage.setImageWithURL(url!)
        //print(url)
        return cell
    }
}
