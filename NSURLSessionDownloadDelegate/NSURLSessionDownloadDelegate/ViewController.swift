//
//  ViewController.swift
//  NSURLSessionDownloadDelegate
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate {
    
    var session = NSURLSession()
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var progreso: UIProgressView!
    
    @IBAction func cargar(sender: UIButton) {
        let imageUrl: NSString = "http://c.hiphotos.baidu.com/image/pic/item/8cb1cb13495409235fa14adf9158d109b2de4942.jpg"
        let getImageTask: NSURLSessionDownloadTask =
        session.downloadTaskWithURL(NSURL(string: imageUrl as String)!)
        getImageTask.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sessionConfig =
        NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        print("Download finished")
        let downloadedImage = UIImage(data: NSData(contentsOfURL: location)!)
        dispatch_async(dispatch_get_main_queue(), {() in
            self.imagen.image = downloadedImage
        })
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64,totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        dispatch_async(dispatch_get_main_queue(), {() in
            let variable = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            self.progreso.progress = variable
        }) }
        
}
