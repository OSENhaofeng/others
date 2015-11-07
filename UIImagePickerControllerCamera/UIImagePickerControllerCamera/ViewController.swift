//
//  ViewController.swift
//  UIImagePickerControllerCamera
//
//  Created by Carlos Butron on 08/12/14.
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
import MobileCoreServices



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func useCamera(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        //to select only camera controls, not video
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.showsCameraControls = true
        //imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image)! as NSData
        
        //save in photo album
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        //save in documents
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        
        
        let filePath = (documentsPath! as NSString).stringByAppendingPathComponent("pic.png")
        imageData.writeToFile(filePath, atomically: true)
        
        myImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if(error != nil){
            print("ERROR IMAGE \(error.debugDescription)")
        }
    }
    
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}



