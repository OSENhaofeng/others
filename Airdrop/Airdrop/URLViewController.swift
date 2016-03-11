//
//  URLViewController.swift
//  Airdrop
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class URLViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var myURL: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func send(sender: UIButton) {
        let url:NSURL = NSURL(string: myURL.text!)!
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func load(sender: UIButton) {
        let request = NSURLRequest(URL: NSURL(string: myURL.text!)!)
        self.webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myURL.text = "http://carlosbutron.es/"
        webView.delegate = self
        let request = NSURLRequest(URL: NSURL(string: myURL.text!)!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
