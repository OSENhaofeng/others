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
        self.webView.loadRequest(request)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
