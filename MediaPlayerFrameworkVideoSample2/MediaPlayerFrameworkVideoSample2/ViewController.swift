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
import MediaPlayer


class ViewController: UIViewController {
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonForward: UIButton!
    @IBOutlet weak var buttonRewind: UIButton!
    @IBOutlet weak var buttonReplay: UIButton!
    
    
    var theMovie:MPMoviePlayerController!
    
    var isPlaying = false
    
    @IBAction func play(sender: UIButton) {
        theMovie.play()
        
    }
    @IBAction func pause(sender: UIButton) {
        theMovie.pause()
        
    }
    @IBAction func forward(sender: UIButton) {
        theMovie.beginSeekingForward()
        
    }
    @IBAction func rewind(sender: UIButton) {
        theMovie.beginSeekingBackward()
        
    }
    
    @IBAction func replay(sender: UIButton) {
        
        theMovie.stop()
        theMovie.play()
        
        buttonReplay.hidden = true
        buttonPlay.hidden = false
        buttonPause.hidden = false
        buttonForward.hidden = false
        buttonRewind.hidden = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonReplay.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayBackDidFinish", name: MPMoviePlayerPlaybackDidFinishNotification, object: theMovie)
        
        let bundle = NSBundle.mainBundle()
        //our video is 02.mov
        let moviePath = bundle.pathForResource("02", ofType: "mov")
        let url = NSURL(fileURLWithPath: moviePath!)
        theMovie = MPMoviePlayerController(contentURL: url)
        theMovie.view.frame = CGRectMake(25.0, 20.0, 270, 270);
        theMovie.controlStyle = MPMovieControlStyle.None
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "didDetectDoubleTap:")
        tapGesture.numberOfTapsRequired = 2
        theMovie.view.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(theMovie.view)
        //theMovie.play()
    }
    
    func didDetectDoubleTap(tap:UITapGestureRecognizer){
        if(isPlaying){
            theMovie.play()
            isPlaying = !isPlaying
        } else{
            theMovie.pause()
            isPlaying = !isPlaying
        }
    }
    
    func moviePlayBackDidFinish(){
        print("Vídeo Terminado")
        buttonPlay.hidden = true
        buttonPause.hidden = true
        buttonForward.hidden = true
        buttonRewind.hidden = true
        buttonReplay.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


