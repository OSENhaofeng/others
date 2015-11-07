//
//  ViewController.swift
//  NSURLSessionDownloadDelegate
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
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
        // Dispose of any resources that can be recreated.
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


