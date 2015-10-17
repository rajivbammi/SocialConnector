//
//  WebViewController.swift
//  SocialConnector
//
//  Created by Rohan Shah on 10/16/15.
//  Copyright © 2015 Rajiv B. All rights reserved.
//

import UIKit
import OAuthSwift

class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    
    var targetURL : NSURL = NSURL()
    let webView : UIWebView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.frame = UIScreen.mainScreen().bounds
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        loadAddressURL()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func handle(url: NSURL) {
        targetURL = url
        super.handle(url)
    }
    func loadAddressURL() {
        let req = NSURLRequest(URL: targetURL)
        self.webView.loadRequest(req)
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL where (url.scheme == "oauth-swift"){
            self.dismissWebViewController()
        }
        return true
    }
}