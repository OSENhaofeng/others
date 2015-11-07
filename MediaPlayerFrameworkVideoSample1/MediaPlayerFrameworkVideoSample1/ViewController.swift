//
//  ViewController.swift
//  MediaPlayerFrameworkVideoSample1
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
import MediaPlayer


class ViewController: UIViewController {
    
    var theMovie:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = NSBundle.mainBundle()
        //our video is 02.mov
        let moviePath = bundle.pathForResource("02", ofType: "mov")
        let url = NSURL(fileURLWithPath: moviePath!)
        theMovie = MPMoviePlayerController(contentURL: url)
        theMovie.view.frame = CGRectMake(25.0, 20.0, 270, 270);
        self.view.addSubview(theMovie.view)
        theMovie.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

