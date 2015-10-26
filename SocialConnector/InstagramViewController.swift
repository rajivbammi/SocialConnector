//
//  InstagramViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/19/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit

class InstagramViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var instagramResults: [InstagramUser]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside InstagramViewController: viewdidload")
        tableView.estimatedRowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        instagramResults  = InstagramClient.sharedInstance.instaResults
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if instagramResults != nil {
            print(instagramResults?.count)
            return (instagramResults?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramTableViewCell", forIndexPath: indexPath) as! InstagramTableViewCell
        let result = instagramResults?[indexPath.row]
        cell.usernameLabel.text = result!.username
        cell.captionLabel.text = result!.captionText

        if (result?.userImgUrl != nil) {
          let userImgUrl = NSURL(string: result?.userImgUrl as String!)
          cell.profileImageView.setImageWithURL(userImgUrl!)
        }
        
        let imgUrl = NSURL(string: result?.imgUrl as String!)
        cell.instaImageView!.setImageWithURL(imgUrl!)
        return cell
    }


}
