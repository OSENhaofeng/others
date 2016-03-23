//
//  ViewController.swift
//  CoreImageCIDetector
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filePath: NSString = ""
    var fileNameAndPath = NSURL()
    var image = CIImage()
    
    override func viewDidLoad() {
        filePath = NSBundle.mainBundle().pathForResource("emotions", ofType: "jpg")!
        fileNameAndPath = NSURL.fileURLWithPath(filePath as String)
        image = CIImage(contentsOfURL:fileNameAndPath)!
        let context = CIContext(options: nil)
        let options = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy)
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options as? [String : AnyObject] )
        let features: NSArray = detector.featuresInImage(image, options: [CIDetectorSmile:true,CIDetectorEyeBlink:true])
        let imageView = UIImageView(image: UIImage(named: "emotions.jpg"))
        self.view.addSubview(imageView)
        
        //auxiliar view to invert.
        let vistAux = UIView(frame: imageView.frame)
        for faceFeature in features {
            
            //Detection
            let smile = faceFeature.hasSmile
            let rightEyeBlinking = faceFeature.rightEyeClosed
            let leftEyeBlinking = faceFeature.leftEyeClosed
            
            //Face location
            let faceRect = faceFeature.bounds
            let faceView = UIView(frame: faceRect)
            faceView.layer.borderWidth = 2
            faceView.layer.borderColor = UIColor.redColor().CGColor
            let faceWidth:CGFloat = faceRect.size.width
            let faceHeight:CGFloat = faceRect.size.height
            vistAux.addSubview(faceView)
            
            //Smile location
            if (smile==true) {
                let smileView = UIView(frame: CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.18, faceFeature.mouthPosition.y-faceHeight*0.1, faceWidth*0.4, faceHeight*0.2))
                smileView.layer.cornerRadius = faceWidth*0.1
                smileView.layer.borderWidth = 2
                smileView.layer.borderColor = UIColor.greenColor().CGColor
                smileView.layer.backgroundColor = UIColor.greenColor().CGColor
                smileView.layer.opacity = 0.5
                vistAux.addSubview(smileView)
            }
            
            //Right eye location
            let rightEyeView = UIView(frame: CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.2, faceFeature.rightEyePosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4))
            rightEyeView.layer.cornerRadius = faceWidth*0.2
            rightEyeView.layer.borderWidth = 2
            rightEyeView.layer.borderColor = UIColor.redColor().CGColor
            if (rightEyeBlinking==true){
                rightEyeView.layer.backgroundColor = UIColor.yellowColor().CGColor
            }else{
                rightEyeView.layer.backgroundColor = UIColor.redColor().CGColor
            }
            rightEyeView.layer.opacity = 0.5
            vistAux.addSubview(rightEyeView)
            
            //Left eye location
            let leftEyeView = UIView(frame: CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.2, faceFeature.leftEyePosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4))
            leftEyeView.layer.cornerRadius = faceWidth*0.2
            leftEyeView.layer.borderWidth = 2
            leftEyeView.layer.borderColor = UIColor.blueColor().CGColor
            if (leftEyeBlinking==true){
                leftEyeView.layer.backgroundColor = UIColor.yellowColor().CGColor
            }else{
                leftEyeView.layer.backgroundColor = UIColor.blueColor().CGColor
            }
            leftEyeView.layer.opacity = 0.5
            vistAux.addSubview(leftEyeView)
        }
        
        self.view.addSubview(vistAux)
        
        //Invert coords
        vistAux.transform = CGAffineTransformMakeScale(1, -1)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
