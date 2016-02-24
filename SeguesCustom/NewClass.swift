//
//  NewClass.swift
//  Segues
//
//  Created by Carlos Butron on 12/04/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class NewClass: UIStoryboardSegue {
    
    override func perform(){
        
        let source : UIViewController = self.sourceViewController 
        let destination : UIViewController = self.destinationViewController 
        
        UIGraphicsBeginImageContext(source.view.bounds.size)
        source.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let sourceImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        destination.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let destinationImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let sourceImageView : UIImageView = UIImageView (image: sourceImage)
        let destinationImageView : UIImageView = UIImageView (image: destinationImage)
        source.view.addSubview(sourceImageView)
        source.view.addSubview(destinationImageView)
        destinationImageView.transform = CGAffineTransformMakeTranslation(destinationImageView.frame.size.width, 0)
        
        UIView.animateWithDuration(1.0, animations: { () in
            sourceImageView.transform = CGAffineTransformMakeTranslation(-sourceImageView.frame.size.width, 0)
            destinationImageView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: { (finished) in
                source.presentViewController(destination, animated: true, completion: nil)
        }) }
    
}
