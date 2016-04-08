//
//  ViewController.swift
//  iAdFramework
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        
        let bannerView = ADBannerView(adType: .MediumRectangle)
        bannerView.delegate = self
        bannerView.center = self.view.center
        bannerView.hidden = false
        self.view.addSubview(bannerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
