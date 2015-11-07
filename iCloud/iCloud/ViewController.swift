//
//  ViewController.swift
//  iCloud
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
import CloudKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var celdas: NSMutableArray = NSMutableArray()
    
    
    var container = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
    var metadataQuery : NSMetadataQuery!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func deletePhotos(sender: UIBarButtonItem) {
        
        removeImagesFromICloud()
    }
    
    @IBAction func choosePhotos(sender: UIBarButtonItem) {
        let action = UIAlertController (title: "Photos", message: "Select source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        action.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("Choose camera")
            self.getPhoto(true)
        }))
        action.addAction(UIAlertAction(title: "Galery", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("Choose galery")
            self.getPhoto(false)
        }))
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    func getPhoto (camera: Bool){
        let picker = UIImagePickerController()
        picker.delegate = self
        if (camera){
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            print("Choose from galery 2")
        }
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let fullImage = (info as NSDictionary)[UIImagePickerControllerOriginalImage] as! UIImage
        print("Choose from galery 3")
        savePhotoICloud(fullImage)
    }
    
    
    
    
    func savePhotoICloud (image: UIImage){
        let date = NSDate()
        let df = NSDateFormatter()
        df.dateFormat = "dd_MM_yy_hh_mm_ss"
        
        let photoName = NSString (format: "PHOTO_%@", df.stringFromDate(date))
        
        if (container != nil){
            let fileURLiCloud = container!.URLByAppendingPathComponent("Documents").URLByAppendingPathComponent(photoName as String)
            let photo = DocumentPhoto (fileURL: fileURLiCloud)
            photo.image = image
            
            photo.saveToURL(fileURLiCloud, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: { (success) -> Void
                in
                self.celdas.addObject(image)
                print("Choose from galery 4")
                self.collectionView.reloadData()
            })
        }
    }
    
    
    func removeImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryDeleted:", name: NSMetadataQueryDidFinishGatheringNotification,
                object: self.metadataQuery)
            
            self.metadataQuery.startQuery()
        }
    }
    
    func loadImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryFinished:", name: NSMetadataQueryDidFinishGatheringNotification,
                object: self.metadataQuery)
            
            self.metadataQuery.startQuery()
        }
    }
    
    func queryFinished(notification: NSNotification){
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stopQuery()
        celdas.removeAllObjects()
        for (var i = 0; i<mq.resultCount;i++){
            let result = mq.resultAtIndex(i) as! NSMetadataItem
           // var nombre = result.valueForAttribute(NSMetadataItemFSNameKey) as! NSString
            let url = result.valueForAttribute(NSMetadataItemURLKey) as! NSURL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            
            document?.openWithCompletionHandler({ (success) -> Void in
                if (success == true){
                    self.celdas.addObject(document.image)
                    print("addobject in queryfinished")
                    self.collectionView.reloadData()
                }
            }) }
    }
    
    
    func queryDeleted(notification: NSNotification){
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stopQuery()
        celdas.removeAllObjects()
        for (var i = 0; i<mq.resultCount;i++){
            let result = mq.resultAtIndex(i) as! NSMetadataItem
           // var nombre = result.valueForAttribute(NSMetadataItemFSNameKey) as! NSString
            let url = result.valueForAttribute(NSMetadataItemURLKey) as! NSURL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            
            let fileManager = NSFileManager()
            do {
                try fileManager.removeItemAtURL(document.fileURL)
            } catch _ {
            }
            
            self.collectionView.reloadData()
            
            document?.openWithCompletionHandler({ (success) -> Void in
                if (success == true){
                    
                    self.collectionView.reloadData()
                }
            }) }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        savePhotoICloud(UIImage(named: "fondo1.jpg")!)
        loadImagesFromICloud ()
        //        self.collectionView.reloadData()
        //        var imagenView: UIImageView = UIImageView()
        //        imagenView.image = UIImage(named: "imagen1.png")
        //        self.celdas.addObject(imagenView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier:NSString = "CollectionCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) 
        
        
        
        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = celdas.objectAtIndex(indexPath.row) as? UIImage
        // imageView.image = UIImage(named: "imagen1.png")
        
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celdas.count
    }
    
    
}


