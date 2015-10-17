//
//  ViewController.swift
//  SocialConnector
//
//  Created by Rajiv Bammi on 10/16/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var services = ["Twitter", "Flickr", "Github", "Instagram", "Foursquare", "Fitbit", "Withings", "Linkedin", "Linkedin2", "Dropbox", "Dribbble", "Salesforce", "BitBucket", "GoogleDrive", "Smugmug", "Intuit", "Zaim", "Tumblr", "Slack", "Uber"]
    
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
        doOAuthInstagram()
    }
    
    func doOAuthInstagram(){
        let oauthswift = OAuth2Swift(
            consumerKey:    "ec8e7d4c335945c2a880a86106438b2c",
            consumerSecret: "741a54fb4eee44dab586caa708b4574b",
            authorizeUrl:   "https://api.instagram.com/oauth/authorize",
            responseType:   "token"
        )
        
        let state: String = generateStateWithLength(20) as String
        oauthswift.authorize_url_handler = WebViewController()
        oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/instagram")!, scope: "likes+comments", state:state, success: {
            credential, response, parameters in
            
            NSLog("inside ")
            self.showAlertView("Instagram", message: "oauth_token:\(credential.oauth_token)")
            let url :String = "https://api.instagram.com/v1/users/self/feed?access_token=\(credential.oauth_token)"
            let parameters :Dictionary = Dictionary<String, AnyObject>()
            oauthswift.client.get(url, parameters: parameters,
                success: {
                    data, response in
                    let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                    print(jsonDict)
                }, failure: {(error:NSError!) -> Void in
                    print(error)
            })
            }, failure: {(error:NSError!) -> Void in
                NSLog("fail")
                print(error.localizedDescription)
        })
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return services.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = services[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let service: String = services[indexPath.row]
        switch service {
            //        case "Twitter":
            //            //doOAuthTwitter()
            //        case "Flickr":
            //            //doOAuthFlickr()
            //        case "Github":
            //            //doOAuthGithub()
        case "Instagram":
            doOAuthInstagram()
            //        case "Foursquare":
            //            doOAuthFoursquare()
            //        case "Fitbit":
            //            doOAuthFitbit()
            //        case "Withings":
            //            doOAuthWithings()
            //        case "Linkedin":
            //            doOAuthLinkedin()
            //        case "Linkedin2":
            //            doOAuthLinkedin2()
            //        case "Dropbox":
            //            doOAuthDropbox()
            //        case "Dribbble":
            //            doOAuthDribbble()
            //        case "Salesforce":
            //            doOAuthSalesforce()
            //        case "BitBucket":
            //            doOAuthBitBucket()
            //        case "GoogleDrive":
            //            doOAuthGoogle()
            //        case "Smugmug":
            //            doOAuthSmugmug()
            //        case "Intuit":
            //            doOAuthIntuit()
            //        case "Zaim":
            //            doOAuthZaim()
            //        case "Tumblr":
            //            doOAuthTumblr()
            //        case "Slack":
            //            doOAuthSlack()
            //        case "Uber":
            //            doOAuthUber()
        default:
            print("default (check ViewController tableView)")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

}

