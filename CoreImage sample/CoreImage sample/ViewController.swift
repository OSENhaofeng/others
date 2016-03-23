//
//  ViewController.swift
//  CoreImage sample
//
//  Created by Carlos Butron on 24/09/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    //SLIDER TO FIRST AND SECOND FILTER
    //when you do slider value change
    //then push in filter button  "sepia" or "vignette" to apply it
    var sliderValue: Float = 0.0
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func sepia(sender: UIButton) {
        applyfilter(1);
    }
    
    @IBAction func vignette(sender: UIButton) {
        applyfilter(2);
    }
    
    @IBAction func invert(sender: UIButton) {
        applyfilter(3);
    }
    
    @IBAction func photo(sender: UIButton) {
        applyfilter(4);
    }
    
    @IBAction func perspective(sender: UIButton) {
        applyfilter(5);
    }
    
    @IBAction func gaussian(sender: UIButton) {
        applyfilter(6);
    }
    
    @IBAction func slider(sender: UISlider) {
        sliderValue = sender.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func applyfilter(numberFilter: Int) {
        
        let filePath : NSString = NSBundle.mainBundle().pathForResource("image", ofType: "jpg")!
        let fileUrl : NSURL = NSURL (fileURLWithPath: filePath as String)
        let inputImage : CIImage = CIImage (contentsOfURL: fileUrl)!
        
        switch numberFilter {
        case 1:
            let filter = CIFilter(name: "CISepiaTone")
            //var filter : CIFilter = CIFilter (name: "CISepiaTone")
            filter!.setValue(inputImage, forKey: kCIInputImageKey)
            filter!.setValue(sliderValue, forKey: "InputIntensity")
            let outputImage : CIImage = filter!.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        case 2:
            let filter : CIFilter = CIFilter (name: "CIVignette")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(sliderValue, forKey: "InputRadius")
            filter.setValue(sliderValue, forKey: "InputIntensity")
            let outputImage : CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        case 3:
            let filter : CIFilter = CIFilter (name: "CIColorInvert")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        case 4:
            let filter : CIFilter = CIFilter (name: "CIPhotoEffectMono")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        case 5:
            let filter : CIFilter = CIFilter (name: "CIPerspectiveTransform")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        case 6:
            let filter : CIFilter = CIFilter (name: "CIGaussianBlur")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (CIImage: outputImage)
            myImage.image = img
        default:
            print("test")
        }
    }

}
