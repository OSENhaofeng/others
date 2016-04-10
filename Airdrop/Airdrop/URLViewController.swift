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
    @IBOutlet weak var webView2: UIWebView!
    
    @IBAction func send(sender: UIButton) {
        let url:NSURL = NSURL(string: myURL.text!)!
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func load(sender: UIButton) {
        let request = NSURLRequest(URL: NSURL(string: myURL.text!)!)
        self.webView2.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView2.delegate = self
        
        //1. Load web site into my web view
        
        let myURL = NSURL(string: "http://www.swiftdeveloperblog.com");
        let myURLRequest:NSURLRequest = NSURLRequest(URL: myURL!);
        webView2.loadRequest(myURLRequest);
        
        
        
        
//        // Do any additional setup after loading the view, typically from a nib.
//        let url = NSURL (string: "http://www.google.com");
//        let request = NSURLRequest(URL: url!);
//        webView2.loadRequest(request);
        
//        myURL.text = "http://carlosbutron.es/"
//        webView2.delegate = self
//        let request = NSURLRequest(URL: NSURL(string: myURL.text!)!)
//        self.webView2.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
