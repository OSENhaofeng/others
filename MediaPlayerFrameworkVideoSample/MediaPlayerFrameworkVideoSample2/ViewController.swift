//
//  ViewController.swift
//  MediaPlayerFrameworkVideoSample2
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let destination = segue.destinationViewController as! AVPlayerViewController
            let bundle = NSBundle.mainBundle()
            //our video is 02.mov
            let moviePath = bundle.pathForResource("02", ofType: "mov")
            let url = NSURL(fileURLWithPath: moviePath!)
            destination.player = AVPlayer(URL: url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
