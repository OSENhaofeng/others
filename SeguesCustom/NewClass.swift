//
//  NewClass.swift
//  Segues
//
//  Created by Carlos Butron on 12/04/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
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
