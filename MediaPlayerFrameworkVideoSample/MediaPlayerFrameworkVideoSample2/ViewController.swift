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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destination = segue.destination as! AVPlayerViewController
            let bundle = Bundle.main
            //our video is 02.mov
            let moviePath = bundle.path(forResource: "02", ofType: "mov")
            let url = URL(fileURLWithPath: moviePath!)
            destination.player = AVPlayer(url: url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
