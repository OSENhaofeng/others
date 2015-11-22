//
//  ViewController.swift
//  MediaPlayerFrameworkVideoSample2
//
//  Created by Carlos Butron on 07/12/14.
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
        // Dispose of any resources that can be recreated.
    }
    
    
}


