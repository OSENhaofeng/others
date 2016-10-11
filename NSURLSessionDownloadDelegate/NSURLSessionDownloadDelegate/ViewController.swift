//
//  ViewController.swift
//  NSURLSessionDownloadDelegate
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    var session = Foundation.URLSession()
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var progreso: UIProgressView!
    
    @IBAction func cargar(_ sender: UIButton) {
        let imageUrl: NSString = "http://c.hiphotos.baidu.com/image/pic/item/8cb1cb13495409235fa14adf9158d109b2de4942.jpg"
        let getImageTask: URLSessionDownloadTask =
        session.downloadTask(with: URL(string: imageUrl as String)!)
        getImageTask.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sessionConfig =
        URLSessionConfiguration.default
        session = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        print("Download finished")
        let downloadedImage = UIImage(data: try! Data(contentsOf: location))
        DispatchQueue.main.async(execute: {() in
            self.imagen.image = downloadedImage
        })
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64,totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        DispatchQueue.main.async(execute: {() in
            let variable = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            self.progreso.progress = variable
        }) }
        
}
